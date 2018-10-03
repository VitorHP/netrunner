defmodule Netrunner.Mechanics.Tick do
  def perform(player) do
    %{ player | tick: player[:tick] - 1 }
  end

end
