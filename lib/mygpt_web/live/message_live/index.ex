defmodule MygptWeb.MessageLive.Index do
  use MygptWeb, :live_view

  alias Mygpt.Chatlog
  alias Mygpt.Chatlog.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :messages, Chatlog.list_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Chatlog.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_info({MygptWeb.MessageLive.FormComponent, {:saved, message}}, socket) do
    {:noreply, stream_insert(socket, :messages, message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Chatlog.get_message!(id)
    {:ok, _} = Chatlog.delete_message(message)

    {:noreply, stream_delete(socket, :messages, message)}
  end

  def handle_event("send", _, socket) do
    {:ok, message} = Mygpt.ChatGpt.callapi()

    {:noreply, stream_insert(socket, :messages, message)}
  end
end
