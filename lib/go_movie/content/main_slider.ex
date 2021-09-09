defmodule GoMovie.Content.MainSlider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "main_sliders" do
    field :description, :string
    field :img_url, :string
    field :link_1, :string
    field :link_2, :string
    field :status, :boolean, default: true #indicates if the slider is to be shown
    field :title, :string
    field :order, :integer

    timestamps()
  end

  @doc false
  def changeset(main_slider, attrs) do
    main_slider
    |> cast(attrs, [:title, :description, :img_url, :link_1, :link_2, :status, :order])
    |> unique_constraint(:order)
    |> validate_required([:title, :description, :status, :order])
  end
end
