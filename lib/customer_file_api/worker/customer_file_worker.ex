defmodule CustomerFileApi.Worker.CustomerFileWorker do
  use Oban.Worker,
    queue: :send_file,
    max_attempts: 3

  alias CustomerFileApi.Worker.HandleCustomer


  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    IO.inspect("job iniciado")
    HandleCustomer.generate_file_and_update()
    :ok
  end
end
