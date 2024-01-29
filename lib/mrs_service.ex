defmodule MRS.Service do
  require MRS
  @endpoint "https://registry.dec.gov.ua/api"
  def verify(), do: {:ssl, [{:verify, :verify_none}]}

  def find(id, list), do:
       :lists.flatten(
       :lists.map(fn x ->
           case :maps.get("id", x, []) do
                a when a == id -> x
                _ -> [] end end, list))

  def reduceGet(url, name, pageRequested, count, acc) do
      bearer = :application.get_env(:mrs, :bearer, '')
      accept = 'application/json'
      headers = [{'Authorization',bearer},{'accept',accept}]
      address = '#{@endpoint}#{url}?page=#{pageRequested}&limit=#{count}'
      {:ok,{{_,status,_},_headers,body}} =
         :httpc.request(:get, {address, headers}, [{:timeout,100000},verify()], [{:body_format,:binary}])
      case status do
           500 -> acc
           200 -> res = :jsone.decode(body)
                  pages = Map.get(res, "pages", count)
                  records = Map.get(res, "records", [])
                  :io.format '#{name}: ~p~n', [{status, pages, pageRequested, count, length(records)}]
                  new = :lists.flatten([records|acc])
                  case pageRequested do
                       _ when pageRequested == pages -> new
                       _ -> reduceGet(url, name, (pageRequested+1), count, new)
                  end
      end
  end

  def registry(), do: reduceGet("/registry/", "registry", 1, 1000,  []) # most latency-heavy
  def sku(), do: reduceGet("/registry/sku", "sku", 1, 1000, [])
  def packages(), do: reduceGet("/dictionaries/packagetype", "packages", 1, 1000, [])
  def inn(), do: reduceGet("/dictionaries/inn", "inn", 1, 1000, [])
  def atc(), do: reduceGet("/dictionaries/atc_codes", "atc", 1, 1000, [])
  def manufacturers(), do: reduceGet("/dictionaries/manufacturer", "manufacturer", 1, 1000, [])
  def authholders(), do: reduceGet("/dictionaries/authorizationholder", "authholder", 1, 1000, [])

end
