defmodule Netrunner.Game do
  alias Netrunner.Runner, as: Runner
  alias Netrunner.Corp, as: Corp
  alias Netrunner.Card, as: Card

  defstruct runner: nil,
            corp: nil,
            issues: [],
            turns: [],
            triggers: %{}

  def build do
    %__MODULE__{
      runner: Map.merge(%Runner{}, deck_and_identity(Card.by_ids([
        "yog_0",
        "wyrm",
        "sure_gamble",
        "parasite",
        "datasucker",
        "noise"
      ]))),
      corp: Map.merge(%Corp{}, deck_and_identity(Card.by_ids([
        "pad_campaign",
        "wall_of_static",
        "hedge_fund",
        "private_security_force",
        "enigma",
        "jinteki_personal_evolution"
      ])))
    }
  end

  def setup do
    __MODULE__.build
      |> Netrunner.Actions.dispatch({ :setup, %{ target: :runner } })
      |> Netrunner.Actions.dispatch({ :setup, %{ target: :corp } })
      |> Netrunner.Actions.dispatch({ :set_trigger, %{ target: :corp, event: :start_turn, effect: %{target: :corp, draw: [:deck, :hand, 1]}}})
  end

  def deck_and_identity(deck) do
    Enum.reduce(
      deck,
      %{deck: [], identity: nil},
      fn card, acc ->
        if (Map.get(card, :kind, "") == "identity") do
          Map.put(acc, :identity, card)
        else
          Map.put(acc, :deck, [card | acc.deck])
        end
      end
    )
  end
end
