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
    defaults = %{vus: 1, duration: 10_000, rampup_duration: 0, data_path: "./local-users.jsonl"}
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
    sleep_interval =
      if opts.rampup_duration == 0 do
        0
      else
        (opts.vus - 1) / opts.rampup_duration
      end

    File.stream!(opts.data_path)
    |> Enum.take(opts.vus)
    |> Enum.map(&Jason.decode!/1)
    |> Enum.with_index()
    |> Enum.each(fn {l, idx} ->
      if idx > 0 && sleep_interval > 0, do: :timer.sleep(sleep_interval)

      spec =
        Hailstorm.Party.child_spec(l)
        # don't restart workers (for now)
        |> Map.put(:restart, :temporary)

      {:ok, _} = DynamicSupervisor.start_child(Hailstorm.WorkerSupervisor, spec)
    end)
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
