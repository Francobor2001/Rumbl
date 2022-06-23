defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string

    belongs_to :user, Rumbl.Accounts.User #foreign key N - 1 with user
    belongs_to :category, Rumbl.Multimedia.Category

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    #Using changeset constraints only makes sense if the error message can be something the user can take action on.
    |> assoc_constraint(:category) #check if the association was created correctly, send and error if the category is not in the db
  end
end
