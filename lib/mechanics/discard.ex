
defmodule Netrunner.Mechanics.Discard do
  def perform(player, hand, deck, id) when is_bitstring(id) do
    case Enum.find_index(Map.get(player, hand), &( &1 == id )) do
      nil ->
        { :error, :card_not_in_hand }
      _ ->
        %{ player | deck => [id | Map.get(player, deck)], hand => Enum.reject(Map.get(player, hand), &( &1 == id )) }
    end
  end
end
