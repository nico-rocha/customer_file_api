defmodule CustomerFileApi.Worker.HandleCustomer do
  alias CustomerFileApi.Schemas.CustomerData
  alias CustomerFileApi.Repo, as: CustomerRepo
  import Ecto.Query


  defp get_unimported_customers_query() do
    query =
      from customers in CustomerData,
        where: customers.imported == false

    CustomerRepo.all(query)
  end

  def generate_file_and_update() do
    customers = get_unimported_customers_query()

    file_content = Enum.map(customers, fn %CustomerData{name: name, email: email, age: age} ->
      "#{name}\n#{email}\n#{age}\n"
    end)
    IO.inspect("file content pego")

    File.write("/home/nicoly.rocha/Documentos/Elixir/Projects/customer_file_api/lib/tmp/#{Timex.format!(Timex.today(), "{YYYY}-{0M}-{0D}")}.txt", file_content)
    IO.inspect("file write")

    CustomerRepo.update_all(CustomerData, set: [imported: :true])
    IO.inspect("arquivo")
    :ok
  end
end
