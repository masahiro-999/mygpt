defmodule Mygpt.Chatlog.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :role, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:role, :content])
    |> validate_required([:role, :content])
  end
end
