defmodule Hailstorm.LoadTest.System do
  use Supervisor
  require Logger

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def abort_test() do
    DynamicSupervisor.stop(Hailstorm.WorkerSupervisor, :shutdown)
  end

  def start_test(opts \\ %{}) do
    defaults = %{
      vus: 1,
      duration: 10_000,
      rampup_duration: 0,
      rampup_step: 1,
      data_path: "./local-users.jsonl"
    }

    opts = Map.merge(defaults, opts)

    {:ok, start_pid} =
      DynamicSupervisor.start_child(
        Hailstorm.WorkerSupervisor,
        {Task,
         fn ->
           start_workers(opts)
         end}
      )

    {:ok, _} =
      DynamicSupervisor.start_child(
        Hailstorm.WorkerSupervisor,
        {Task,
         fn ->
           :timer.sleep(opts.duration)
           shutdown_workers(start_pid)
         end}
      )
  end

  defp start_workers(opts) do
    plan = rampup(opts.vus, opts.rampup_duration, opts.rampup_step)

    data =
      File.stream!(opts.data_path)
      |> Enum.take(opts.vus)
      |> Enum.map(&Jason.decode!/1)
      |> Enum.to_list()

    execute_plan(plan, data)
  end

  defp execute_plan([], _), do: nil

  defp execute_plan([{:spawn, n} | rest], data) do
    {data, rest_data} = Enum.split(data, n)

    for d <- data do
      spec =
        Hailstorm.Party.child_spec(d)
        # don't restart workers (for now)
        |> Map.put(:restart, :temporary)

      {:ok, _} = DynamicSupervisor.start_child(Hailstorm.WorkerSupervisor, spec)
    end

    execute_plan(rest, rest_data)
  end

  defp execute_plan([{:sleep, t} | rest], data) do
    :timer.sleep(t)
    execute_plan(rest, data)
  end

  defp shutdown_workers(start_pid) do
    Logger.info("Stopping workers")

    # in case the task that is starting worker is still running, stop that first
    Process.exit(start_pid, :kill)

    DynamicSupervisor.which_children(Hailstorm.WorkerSupervisor)
    |> Enum.each(fn
      {_, pid, _, _} when is_pid(pid) and self() != pid ->
        Hailstorm.Party.shutdown(pid)

      _ ->
        nil
    end)
  end

  @doc """
  returns a list of action so that over `total_duration`, `total_actions` are
  evenly spread, while sleeping by durations multiple of `sleep_step`
  """
  @spec rampup(total_actions :: integer(), total_duration :: number(), sleep_step :: integer()) ::
          [
            {:spawn, non_neg_integer()} | {:sleep, integer()}
          ]
  def rampup(n, t, step \\ 1) do
    cond do
      t == 0 || n == 1 -> [{:spawn, n}]
      true -> do_rampup(n, t, step, t / (n - 1), 0, [])
    end
  end

  defp do_rampup(n, remaining, step, dt, time_to_wait, actions) do
    cond do
      n <= 0 ->
        Enum.reverse(actions)

      remaining < step ->
        do_rampup(0, remaining, step, dt, time_to_wait, [{:spawn, n} | actions])

      time_to_wait >= step ->
        ttw_i = trunc(time_to_wait)
        to_wait = div(ttw_i, step) * step
        actions = [{:sleep, to_wait} | actions]
        do_rampup(n, remaining - to_wait, step, dt, time_to_wait - to_wait, actions)

      true ->
        to_spawn = ((step - time_to_wait) / dt) |> ceil() |> min(n)
        to_wait = to_spawn * dt

        if to_spawn <= 0 do
          # by that point, step - time_to_wait ≠ 0, and then with ceil(x)
          # `to_spawn` is guaranteed to be greater than 0
          raise "unreachable"
        end

        actions = [{:spawn, to_spawn} | actions]
        do_rampup(n - to_spawn, remaining, step, dt, time_to_wait + to_wait, actions)
    end
  end

  @impl true
  def init(_) do
    IO.puts("starting #{__MODULE__}")

    children = [
      {DynamicSupervisor, name: Hailstorm.WorkerSupervisor, strategy: :one_for_one}
      # {Task, &start_workers/0}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
