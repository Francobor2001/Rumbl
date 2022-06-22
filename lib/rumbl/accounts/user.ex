
defmodule Rumbl.Accounts.User do
use Ecto.Schema
import Ecto.Changeset

#User Schema, the field of the struct corresponds with a column in the DB
schema "users" do
field :name,:string
field :username, :string
field :password, :string, virtual: true  #virutal fields only exist in the struct, but NOT in the db
field :password_hash, :string


    timestamps()
end
#PRIVATE LOGIC
#From all the atributtes, we only take the :name and :username and validate from the struct "user (User{})"
def changeset(user, attrs) do
  user
  |> cast(attrs, [:name, :username]) #converts a raw map of user input to a changeset, accepting only the :name and :username keys.
  |> validate_required([:name, :username])
  |> validate_length(:username, min: 1, max: 20)

end
#Check if the password is correct and create an encripted password in the db
def registration_changeset(user, params) do
  IO.inspect(params)
   user
|> changeset(params)
|> cast(params, [:password])
|> validate_required([:password])
|> validate_length(:password, min: 6, max: 100)
|> put_pass_hash()


end

def put_pass_hash(changeset) do
  case changeset do
#In case te passw is valid, we add the password to "changes" in the changeset
    %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
       put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass)) #puts in the password_has column, the pas with encryptation

        _ ->
          changeset
    end
end

end
