defmodule GoMovie.Cache.Sliders do
  use GenServer

  alias GoMovie.MongoModel.Movie
  alias GoMovie.MongoModel.Serie

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  @impl true
  def init(_) do
    movies_sliders_backup = resource_file?('movies_sliders', :movies_sliders)
    series_sliders_backup = resource_file?('series_sliders', :series_sliders)

    if movies_sliders_backup == false do
      :ets.new(:movies_sliders, [:set, :public, :named_table, {:read_concurrency, true}])
    end

    if series_sliders_backup == false do
      :ets.new(:series_sliders, [:set, :public, :named_table, {:read_concurrency, true}])
    end

    {:ok, []}
  end

  def resource_file?(filename, table_name) do
    case :ets.file2tab(filename) do
      {:error, _} -> false
      {:ok, ^table_name} -> true
    end
  end

  def get_movies_sliders() do
    get_all_resources(:movies_sliders)
    |> order()
  end

  def get_series_sliders() do
    get_all_resources(:series_sliders)
    |> order()
  end

  def add_series_sliders(series_ids) when is_list(series_ids) do
    clear_table(:series_sliders)

    series = Serie.get_series_by_ids(series_ids, [:name, :_id, :landscape_poster_url, :poster_url])

    series = set_order(series_ids, series)

    series |> Enum.each(&add_resource(&1, :series_sliders))

    :ets.tab2file(:series_sliders, 'series_sliders')
  end

  def add_movies_sliders(movies_ids) when is_list(movies_ids) do
    clear_table(:movies_sliders)

    movies = Movie.get_movies_by_ids(movies_ids, [:name, :_id, :landscape_poster_url, :poster_url, :resource_file_url
    ])

    movies = set_order(movies_ids, movies)

    movies |> Enum.each(&add_resource(&1, :movies_sliders))

    :ets.tab2file(:movies_sliders, 'movies_sliders')
  end

  def set_order(ids, resources) do
    ids
    |> Enum.with_index()
    |> Enum.map(fn {id, index} ->
      Enum.find(resources, &(&1["_id"] == id))
      |> Map.put("order", index)
    end)
  end

  def order(resources) do
    Enum.sort(resources, &(&1["order"] < &2["order"]))
  end

  def add_resource(resource, table_name) do
    :ets.insert(table_name, {resource["_id"], resource})
  end

  def delete_resource(resource_id, table_name) do
    :ets.delete(table_name, resource_id)
  end

  def get_all_resources(table_name) do
    :ets.tab2list(table_name)
    |> Enum.map(fn {_id, resource} -> resource end)
  end

  def clear_table(table_name) do
    get_all_resources(table_name)
    |> Enum.map(&Map.get(&1, "_id"))
    |> Enum.each(&delete_resource(&1, table_name))
  end
end
