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
      runner: %Runner{stack: [
        "yog_0",
        "wyrm",
        "sure_gamble",
        "parasite",
        "datasucker",
      ]},
      corp: %Corp{rnd: [
        "pad_campaign",
        "wall_of_static",
        "hedge_fund",
        "private_security_force",
        "enigma"
      ]}
    }
  end

  def dispatch(state, { action, args } = params) do
    apply(Netrunner.Actions, action, [state | args])
  end

  def sc do
    __MODULE__.build
    |> __MODULE__.dispatch({ :setup, [] })
  end
end
