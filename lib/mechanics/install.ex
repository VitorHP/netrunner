defmodule Netrunner.Mechanics.Install do
  def perform(player, %{ kind: 'resource' } = card, :rig) do
    %{ player | resources: [card | player[:resources]] }
  end

  def perform(player, %{ kind: 'program' } = card, :rig) do
    %{ player | programs: [card | player[:programs]] }
  end

  def perform(player, %{ kind: 'hardware' } = card, :rig) do
    %{ player | hardware: [card | player[:hardware]] }
  end
end
