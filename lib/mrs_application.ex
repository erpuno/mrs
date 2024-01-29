defmodule MRS.Application do
  use Application

  def loadDEC() do
      :filelib.ensure_dir("priv/")
      spawn(fn ->
        MRS.Data.convertATC()
        MRS.Data.convertINN()
        MRS.Data.convertPackage()
        MRS.Data.convertManufacturer()
        MRS.Data.convertSKU()
      end)
  end

  def start(_, _) do
      children = [ ]
      opts = [strategy: :one_for_one, name: App.Supervisor]
      :io.format "MRS Medical Registry System Client [https://registry.dec.gov.ua/api/docs].~n"
      case :application.get_env(:mrs, :load_on_start, false) do
           true -> loadDEC()
           false -> :skip
      end
      Supervisor.start_link(children, opts)
  end
end
