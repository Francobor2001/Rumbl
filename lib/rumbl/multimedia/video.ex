defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset
  #use the custom type, so we get the id from an URL
  @primary_key {:id, Rumbl.Multimedia.Permalink, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    field :slug, :string

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
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do #in case of the title being modified, we change the slug
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

defp slugify(str) do str
|> String.downcase()
|> String.replace(~r/[^\w-]+/u, "-") end

end
