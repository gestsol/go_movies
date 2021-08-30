defmodule GoMovie.News do
  use Tesla

  import SweetXml

  @base_url "https://www.cooperativa.cl"

  plug Tesla.Middleware.BaseUrl, @base_url
  plug Tesla.Middleware.Headers, [{"content-type", "application/xml"}]

  def get_news() do
    {:ok, response} = get("/noticias/site/tax/port/all/rss_4_4__1.xml")

    response
    |> Map.get(:body)
    |> SweetXml.xmap(
      items: [
        ~x"//channel/item"l,
        pubDate: ~x"./pubDate/text()",
        title: ~x"./title/text()",
        link: ~x"./link/text()",
        guid: ~x"./guid/text()",
        description: ~x"./description/text()",
        prontus_foto207: ~x"./prontus_foto207/text()",
        prontus_foto136: ~x"./prontus_foto136/text()",
        prontus_foto388: ~x"./prontus_foto388/text()",
        prontus_foto640: ~x"./prontus_foto640/text()",
        prontus_fotolibre: ~x"./prontus_fotolibre/text()",
        prontus_seccion: ~x"./prontus_seccion/text()",
        prontus_tema: ~x"./prontus_tema/text()",
        prontus_titular_corto: ~x"./prontus_titular_corto/text()",
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

        acc = Map.put acc, k, parsed_val

        append_base_url_to_images_fields(acc, k, parsed_val)
      else
        acc
      end

    end)
  end

  def append_base_url_to_images_fields(doc, field, value) do
    unless is_nil(value) do
      case field do
        :prontus_foto207 -> Map.put doc, field, @base_url <> value
        :prontus_foto136 -> Map.put doc, field, @base_url <> value
        :prontus_foto388 -> Map.put doc, field, @base_url <> value
        :prontus_foto640 -> Map.put doc, field, @base_url <> value
        :prontus_fotolibre -> Map.put doc, field, @base_url <> value
        _ -> doc
      end
    else
      doc
    end
  end
end
