defmodule GoMovie.FallbackNews do
  use Tesla

  import SweetXml

  @base_url "https://www.elmostrador.cl"

  plug Tesla.Middleware.Timeout, timeout: 20_000
  plug Tesla.Middleware.BaseUrl, @base_url
  plug Tesla.Middleware.Headers, [{"content-type", "application/xml"}]

  def get_news() do
    case get("/multimedia/feed/") do
      {:ok, response} -> {:ok, handle_response(response)}
      {:error, _} -> {:error, "Unable to get news."}
    end
  end

  def handle_response(response) do
    response
    |> Map.get(:body)
    |> SweetXml.xmap(
      items: [
        ~x"//channel/item"l,
        pubDate: ~x"./pubDate/text()",
        title: ~x"./title/text()",
        link: ~x"./link/text()",
        prontus_foto207: ~x"./image/text()",
      ])
    |> Map.get(:items)
    |> parse_news()
  end

  def parse_news(docs) do
    docs
    |> Enum.map(&parse_chars_to_strings/1)
  end

  @doc """
  Convierte los valores del documento XML en strings.
  Esto se hace porque la libreria SweetXml los devuelve como charlist
  """
  def parse_chars_to_strings(doc) do
    Enum.reduce(doc, doc, fn {k, v}, acc ->
      if v do
        parsed_val = List.to_string(v)
        Map.put acc, k, parsed_val
      else
        acc
      end
    end)
    |> Map.put(:sitio_fuente, @base_url)
  end

end
