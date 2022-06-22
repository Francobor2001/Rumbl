defmodule RumblWeb.UserController do
  use RumblWeb, :controller

alias Rumbl.Accounts
alias Rumbl.Accounts.User

#we plug the "authenticate" function and it executes before very action
plug :authenticate when action in [:index, :show]



def index(conn, _params) do
  users = Accounts.list_users()
  render(conn, "index.html", users: users)
  end


                #I get the id from the parameters of the URL
  def show(conn, %{"id" => id}) do
        user = Accounts.get_user(id)
        render(conn, "show.html", user: user)
    end


  #Es como el metodo GET de c#, no obtiene parametros y solo muestra la vista
  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
      |> RumblWeb.Auth.login(user)
      |> put_flash(:info, "#{user.name} created!")
      |> redirect(to: Routes.user_path(conn, :index))

      #in case of error in validation, returns a message error
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
      end
    end

#If there’s a current user, we return the connection unchanged.
#Otherwise we store a flash message and redirect back to our application root.
defp authenticate(conn, _opts) do
  if conn.assigns.current_user do
  conn
  else
  conn
  |> put_flash(:error, "You must be logged in to access that page")
  |> redirect(to: Routes.page_path(conn, :index))
  |> halt()
  end
end
end
