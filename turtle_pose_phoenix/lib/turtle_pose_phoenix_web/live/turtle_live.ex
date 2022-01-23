defmodule TurtlePosePhoenixWeb.TurtleLive do
  use TurtlePosePhoenixWeb, :live_view

  @pname {:global, :turtle}

  def mount(_param, _session, socket) do
    if connected?(socket) do
      TurtlePosePhoenix.Server.start_link(@pname, self())
    end

    {:ok, assign(socket, x: "...", y: "...")}
  end

  def handle_info({:pose, %{x: pose_x, y: pose_y}}, socket) do
    {:noreply, assign(socket, x: pose_x, y: pose_y)}
  end
end
