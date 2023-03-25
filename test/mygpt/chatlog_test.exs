defmodule Mygpt.ChatlogTest do
  use Mygpt.DataCase

  alias Mygpt.Chatlog

  describe "messages" do
    alias Mygpt.Chatlog.Message

    import Mygpt.ChatlogFixtures

    @invalid_attrs %{content: nil, role: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chatlog.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chatlog.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{content: "some content", role: 42}

      assert {:ok, %Message{} = message} = Chatlog.create_message(valid_attrs)
      assert message.content == "some content"
      assert message.role == 42
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chatlog.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{content: "some updated content", role: 43}

      assert {:ok, %Message{} = message} = Chatlog.update_message(message, update_attrs)
      assert message.content == "some updated content"
      assert message.role == 43
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chatlog.update_message(message, @invalid_attrs)
      assert message == Chatlog.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chatlog.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chatlog.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chatlog.change_message(message)
    end
  end
end
