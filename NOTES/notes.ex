#----WEB FOR MIGRATION INFORMATION
https://devhints.io/phoenix-migrations


#Create migration
mix ecto.gen.migration create_users

#Define the migration created earlier
defmodule Rumbl.Repo.Migrations.CreateUsers do

use Ecto.Migration
def change do
create table(:users) do
add :name, :string
add :username, :string, null: false add :password_hash, :string
end
create unique_index(:users, [:username]) end
end

#UP migration
mix ecto.migrate


#insert into DB
iex> alias Rumbl.Repo
iex> alias Rumbl.Accounts.User
iex> Repo.insert(%User{
...> name: "José", username: "josevalim"
...> })

#see al routers
mix phx.routes

#------HACER CONSULTAS

#alias Rumbl.Repo  #Para hacer consultas, Repo.(metodo)
#alias Rumbl.User  #The Shema
# import Ecto.Query #Consultzs dentro de los metodos del Repo

#Repo.get(User, 1)

#Repo.insert(%User{name: "pepe", username: "josevalim

#Repo.get_user!(User,1)  #Rises an error



#----Changeset
#Ejem
Ecto.Changeset<
action: nil,
changes: %{name: "fdfs", username: "fdsf"},
errors: [],
data: #Rumbl.Accounts.User<>,
valid?: true
>

#----Plug.Conn
#This module defines a struct and the main
#unctions for working with requests and responses in an HTTP connection.

#Plug.Conn fields:
host
The requested host. For example, www.pragprog.com.

method
The request method. For example, GET or POST.

path_info
The path, split into a List of segments. For example, ["admin", "users"].

req_headers
A list of request headers. For example, [{"content-type", "text/plain"}].

scheme
The request protocol as an atom. For example, :https.

#---fetchable fields, they are empty until you expliciry request it

cookies
These are the request cookies with the response cookies.

params
These are the request parameters. Some plugs help to parse these parameters from the query string,
or from the request body.

#Fields for response
resp_body
Initially an empty string, the response body will contain the HTTP response string when it’s available.

resp_cookies
The resp_cookies has the outbound cookies for the response.

resp_headers
These headers follow the HTTP specification and contain information such as the response
 type and caching rules.

status
The response code generally contains 200–299 for success, 300–399 for redirects,
 400–499 for bad client requests such as not-found, and 500+ for server errors.