defmodule Netrunner.Card do
  @cards elem(YamlElixir.read_from_file(File.cwd!() |> Path.join("data/cards.yml")), 1)

  def by_id(id) when is_atom(id), do: by_id(Atom.to_string(id))

  def by_id(id), do: @cards |> Map.get(id) |> AtomicMap.convert(%{safe: false})
end
