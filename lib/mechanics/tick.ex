defmodule Netrunner.Mechanics.Click do
  def perform(player) do
    %{ player | clicks: player[:clicks] - 1 }
  end

end
