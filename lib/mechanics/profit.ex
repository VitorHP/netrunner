defmodule Netrunner.Mechanics.Profit do
  def perform(player, value) do
    %{ player | credits: player.credits + value }
  end
end
