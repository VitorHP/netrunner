defmodule Netrunner.Game do
  alias Netrunner.Runner, as: Runner
  alias Netrunner.Corp, as: Corp

  defstruct runner: nil,
            corp: nil,
            issues: [],
            turns: [],
            triggers: %{}

  def build do
    %__MODULE__{
      runner: %Runner{deck: [
        "yog_0",
        "wyrm",
        "sure_gamble",
        "parasite",
        "datasucker",
      ]},
      corp: %Corp{deck: [
        "pad_campaign",
        "wall_of_static",
        "hedge_fund",
        "private_security_force",
        "enigma"
      ]}
    }
  end

  def setup do
    __MODULE__.build
      |> Netrunner.Actions.dispatch({ :setup, %{ target: :runner } })
      |> Netrunner.Actions.dispatch({ :setup, %{ target: :corp } })
      |> Netrunner.Actions.dispatch({ :set_trigger, %{ target: :corp, event: :start_turn, effect: %{target: :corp, draw: [:deck, :hand, 1]}}})
  end
end
