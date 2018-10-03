defmodule Netrunner.Mechanics.Pay do
  def perform(player, %{ cost: value } = card) do
    %{ player | credits: player[:credits] - value }
  end
end
