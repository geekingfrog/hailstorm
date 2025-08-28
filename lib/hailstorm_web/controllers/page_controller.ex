defmodule HailstormWeb.PageController do
  use HailstormWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
