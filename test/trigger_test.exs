
defmodule Netrunner.TriggerTest do
  use ExUnit.Case
  doctest Netrunner.Trigger

  test "creates a trigger" do
    game = Netrunner.Trigger.register(%Netrunner.Game{}, :runner, %{id: "cyberfeeder", start_turn: [%{profit: 1}]})
    assert game.triggers == %{start_turn: [%{target: :runner, origin: "cyberfeeder", profit: 1}]}
  end
end
