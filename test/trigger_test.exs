defmodule Netrunner.TriggerTest do
  use ExUnit.Case
  doctest Netrunner.Trigger

  test "creates a trigger" do
    triggers =
      Netrunner.Trigger.register_card(%{}, :runner, %{
        id: "cyberfeeder",
        start_turn: [%{profit: 1}]
      })

    assert triggers == %{start_turn: [%{target: :runner, origin: "cyberfeeder", profit: 1}]}
  end
end
