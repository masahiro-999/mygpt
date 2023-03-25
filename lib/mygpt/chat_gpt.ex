defmodule Mygpt.ChatGpt do
  alias Mygpt.Chatlog

  def callapi() do
    messages =
      Chatlog.list_messages()
      |> Enum.map(fn %{content: content, role: role_num} ->
        %{content: content, role: to_str(role_num)}
      end)

    {:ok, result} =
      OpenAI.chat_completion(
        model: "gpt-3.5-turbo",
        messages: messages
      )
      |> IO.inspect(label: "api result")

    message = hd(result.choices)["message"]

    new_message = %{
      content: message["content"],
      role: to_num(message["role"])
    }

    Chatlog.create_message(new_message)
  end

  def to_num(str) do
    case str do
      "system" -> 0
      "user" -> 1
      "assistant" -> 2
    end
  end

  def to_str(role_num) do
    case role_num do
      0 -> "system"
      1 -> "user"
      2 -> "assistant"
    end
  end
end
