defmodule  LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <h1>Front Porch Light</h1>
      <div id="light">
        <div class="meter">
          <span style="width: <%= @brightness %>%">
            <%= @brightness %>%
          </span>
        </div>

        <button phx-click="off">
          <img src="images/light-off.svg">
        </button>

        <button phx-click="down">
          <img src="images/down.svg">
        </button>

        <button phx-click="up">
          <img src="images/up.svg">
        </button>

        <button phx-click="on">
          <img src="images/light-on.svg">
        </button>

        <button phx-click="light-me-up">
          Light Me Up!
        </button>

        <form phx-change="update">
            <input type="range" min="1" max="100" name="brightness" value="<%= @brightness %>" />
        </form>
      </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("light-me-up", _, socket) do
    socket = assign(socket, :brightness, Enum.random(0..100))
    {:noreply, socket}
  end

  def handle_event("update", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    socket = assign(socket, brightness: brightness)
    {:noreply, socket}
  end
end