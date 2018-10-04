
defmodule Netrunner.Mechanics.Draw do
  def perform(player, deck, hand, 0) do
    player
  end

  def perform(player, deck, hand, amount) do
    case Map.get(player, deck) do
      [] ->
        player
      _ ->
        [drawn | tail] = Map.get(player, deck)

        perform(%{ player | deck => tail, hand => [drawn | Map.get(player, hand)] }, deck, hand, amount - 1)
    end
  end
end
