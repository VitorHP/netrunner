defmodule Netrunner.Mechanics.Shuffle do
  def perform(player, deck) do
    %{ player | deck => Enum.shuffle(Map.get(player, deck)) }
  end
end
