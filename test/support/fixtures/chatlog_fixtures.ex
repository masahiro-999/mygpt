defmodule Mygpt.ChatlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mygpt.Chatlog` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content",
        role: 42
      })
      |> Mygpt.Chatlog.create_message()

    message
  end
end
