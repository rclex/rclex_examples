defmodule TurtlePosePhoenixWeb.PageController do
  use TurtlePosePhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
