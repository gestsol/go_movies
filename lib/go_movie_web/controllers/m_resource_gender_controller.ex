defmodule GoMovieWeb.MResourceGenderController do
  use GoMovieWeb, :controller

  action_fallback GoMovieWeb.FallbackController

  def index(conn, _params) do
    genders = Mongo.find(:mongo, "genders", %{})

    genders_filtered = genders
    |> Enum.map(fn x -> Map.delete(x, "_id") end)

    json(conn, genders_filtered)
  end

  def create(conn, %{"gender" => gender_params}) do
     # GENERATE SEQUENCE ID
     {:ok , counter} = Mongo.find_one_and_update(:mongo, "counters", %{_id: "gender_id" }, %{"$inc": %{sequence_value: 1}})
     gender_merge = Map.merge(gender_params, %{"id_gender" => counter["sequence_value"] })

     {:ok, gender }  = Mongo.insert_one(:mongo, "genders", gender_merge)
     #IO.inspect(resource_movie)

     gender_get = Mongo.find_one(:mongo, "genders", %{id_gender: counter["sequence_value"]})

     json(conn, gender_get |> Map.delete("_id"))
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    genders = Mongo.find_one(:mongo, "genders", %{id_gender: String.to_integer(id)})
    json(conn, genders |> Map.delete("_id"))

  end

  def update(conn, %{"id" => id, "gender" => gender_params}) do
    {:ok, gender} = Mongo.find_one_and_update(:mongo, "genders", %{id_gender: String.to_integer(id)}, %{"$set": gender_params})
    # IO.inspect(resource_movie)

     gender_get = Mongo.find_one(:mongo, "genders", %{id_gender: String.to_integer(id)})

     json(conn, gender_get |> Map.delete("_id"))
  end

  def delete(conn, %{"id" => id}) do
    {:ok, result} = Mongo.delete_one(:mongo, "genders", %{id_gender: String.to_integer(id)})
    #IO.inspect( result)

    send_resp(conn, :no_content, "")
  end
end
