defmodule RumblWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias RumblWeb.Router.Helpers, as: Routes

  # ----------------------- PUBLIC METHODS FOR THE CONTROLLERS
  def init(opts), do: opts

  # asigna a la conexion el usuario
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id) #obtains the id from the user in the connection

    cond do
      conn.assigns[:current_user] ->
        conn  #if sees we already have a current_user, returns the connection (this is for testing)


      user = user_id && Rumbl.Accounts.get_user(user_id) ->
        assign(conn, :current_user, user)#assign the user to the atom :current_user in the conn


      true ->
        assign(conn, :current_user, nil)
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  # If there’s a current user, we return the connection unchanged.
  # Otherwise we store a flash message and redirect back to our application root.
  def authenticate_user(conn, _opts) do
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
