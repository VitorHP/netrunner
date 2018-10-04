defmodule Netrunner.Game do
  alias Netrunner.Runner, as: Runner
  alias Netrunner.Corp, as: Corp
  alias Netrunner.Turn, as: Turn

  @players [:runner, :corp]

  defstruct runner: nil,
            corp: nil,
            turns: []

  def build() do
    %__MODULE__{ runner: %Runner{}, corp: %Corp{} }
  end

  def new_turn(%__MODULE__{ turns: [] } = game) do
    %{ game | turns: [%Turn{ player: :corp }] }
  end

  def new_turn(%__MODULE__{ turns: [last_turn | turns] } = game) do
    %{ game | turns: [%Turn{ player: new_turn_player(last_turn) } | game.turns] }
  end

  defp new_turn_player(last_turn) do
    Enum.find(@players, fn x -> x !== last_turn.player end)
  end
end
