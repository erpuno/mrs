defmodule MRS.Service do
  require MRS

  def verify(), do: {:ssl, [{:verify, :verify_none}]}
  def find(id, listOfMaps), do:
       :lists.flatten(
       :lists.map(fn x ->
           case :maps.get("id", x, []) do
                a when a == id -> x
                _ -> [] end end, listOfMaps))

  @endpoint (:application.get_env(:mrs, :endpoint, "https://registry.dec.gov.ua/api"))
  def reduceGet(url, name, pageRequested, count, acc, changes \\ "") do
      bearer = :application.get_env(:mrs, :bearer, '')
      accept = 'application/json'
      headers = [{'Authorization',bearer},{'accept',accept}]
      address = '#{@endpoint}#{url}?#{changes}page=#{pageRequested}&limit=#{count}'
      {:ok,{{_,status,_},_headers,body}} =
         :httpc.request(:get, {address, headers},
           [{:timeout,100000},verify()], [{:body_format,:binary}])
      case status do
           _ when status >= 100 and status < 200 -> :io.format 'WebSockets not supported: ~p', [body] ; acc
           _ when status >= 500 and status < 600 -> :io.format 'Fatal Error: ~p',              [body] ; acc
           _ when status >= 400 and status < 500 -> :io.format 'Resource not available: ~p',   [address] ; acc
           _ when status >= 300 and status < 400 -> :io.format 'Go away: ~p',                  [body] ; acc
           _ when status >= 200 and status < 300 ->
                  res     = :jsone.decode(body)
                  pages   = Map.get(res, "pages", count)
                  records = Map.get(res, "records", [])
                  :io.format '#{name}: ~p~n', [{status, pages, pageRequested, count, length(records)}]
                  new = :lists.flatten([records|acc])
                  case pageRequested do
                       _ when pageRequested == pages -> new
                       _ -> reduceGet(url, name, (pageRequested+1), count, new, changes)
                  end
      end
  end

  def registry(),      do: reduceGet("/registry/",                        "registry",     1, 500,  []) # most latency-heavy
  def changes(),       do: reduceGet("/registry/changes" ,                "changes",      1, 500,  [], "type=diff&modified_after=2021-12-19&")
  def sku(),           do: reduceGet("/registry/sku",                     "sku",          1, 1000, [])
  def packages(),      do: reduceGet("/dictionaries/packagetype",         "packages",     1, 1000, [])
  def inn(),           do: reduceGet("/dictionaries/inn",                 "inn",          1, 1000, [])
  def atc(),           do: reduceGet("/dictionaries/atc_codes",           "atc",          1, 1000, [])
  def manufacturers(), do: reduceGet("/dictionaries/manufacturer",        "manufacturer", 1, 1000, [])
  def authholders(),   do: reduceGet("/dictionaries/authorizationholder", "authholder",   1, 1000, [])

end

