defmodule CustomerFileApiWeb.CustomerFileController do
  use CustomerFileApiWeb, :controller

  alias CustomerFileApi.CustomerFile
  alias CustomerFileApi.Schemas.CustomerData

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with CustomerFile.get_file(id) do
      conn
      |> put_status(200)
      |> put_resp_header("content-type", "application/json")
      |> send_resp(200, "certo")
    end
  end

  def create(conn, %{"name" => name, "email" => email, "age" => age} = file_params) do
    with {:ok, %CustomerData{}} <- CustomerFile.create_file(file_params) do
      conn
      |> put_status(201)
      |> put_resp_header("content-type", "application/json")
      |> send_resp(201, "#{name}, #{email}, #{age}")
    end
  end

  def update(conn, %{"name" => name, "email" => email, "age" => age} = file_params) do
    with {:ok, %CustomerData{}} <- CustomerFile.create_file(file_params) do
      conn
      |> put_status(200)
      |> put_resp_header("content-type", "application/json")
      |> send_resp(200, "#{name}, #{email}, #{age}")
    end
  end

  def delete(conn, %{"id" => id}) do
    file_id = CustomerFile.get_file(id)

    with {:ok, %CustomerData{}} <- CustomerFile.delete_file(file_id) do
      conn
      |> put_status(:no_content)
      |> put_resp_header("content-type", "application/json")
      |> send_resp(204, "Deletado")
    else
      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> put_resp_header("content-type", "application/json")
        |> send_resp(404, "not found")
    end
  end
end
