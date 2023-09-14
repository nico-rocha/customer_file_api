defmodule CustomerFileApi.CustomerFile do
  alias CustomerFileApi.Repo, as: CustomerRepo
  alias CustomerFileApi.Schemas.CustomerData
  alias Ecto.UUID

  def get_file(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  def get(uuid) do
    case CustomerRepo.get(CustomerData, uuid) do
      nil -> {:error, "File not found!"}
      path -> {:ok, path}
    end
  end

  def create_file(file_params) do
    index_schema = %{
      name: [type: :string, required: true],
      email: [
        type: :string,
        required: true
      ],
      age: [type: :integer, number: [greater_than: 0], required: true]
    }

    with {:ok, data} <- Tarams.cast(file_params, index_schema) do
      %CustomerData{}
      |> CustomerData.changeset(data)
      |> CustomerRepo.insert()
    else
      {:error, error} -> error
    end
  end

  def update_file(file_params) do
    index_schema = %{
      name: [type: :string, required: true],
      email: [
        type: :string,
        required: true
      ],
      age: [type: :integer, number: [greater_than: 0], required: true]
    }

    with {:ok, data} <- Tarams.cast(file_params, index_schema) do
      %CustomerData{}
      |> CustomerData.changeset(data)
      |> CustomerRepo.update()
    else
      {:error, error} -> error
    end
  end

  def delete_file(%CustomerData{} = file) do
    CustomerRepo.delete(file)
  end

  def delete_file({:error, _reason}), do: {:error, "Invalid ID format!"}
end
