defmodule Mygpt.ChatGpt do
  alias Mygpt.Chatlog

  @role_table %{system: 0, user: 1, assistant: 2}

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
    @role_table[String.to_atom(str)]
  end

  def to_str(role_num) do
    @role_table
    |> Map.filter(fn {_key, value} -> value == role_num end)
    |> Map.keys()
    |> hd()
    |> to_string()
  end
end
