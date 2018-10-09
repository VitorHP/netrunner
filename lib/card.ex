defmodule Netrunner.Card do
  @cards elem(YamlElixir.read_from_file(File.cwd!() |> Path.join("data/cards.yml")), 1) |> AtomicMap.convert(%{safe: false})

  def by_id(id) when is_atom(id), do: @cards |> Map.get(id)

  def by_id(id), do: by_id(String.to_atom(id))

  def by_ids(ids) do
    Enum.map ids, &(Map.get(@cards, String.to_atom(&1)))
  end
end
