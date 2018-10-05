defmodule Netrunner.Mechanics.DiscardTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Discard

  test "discard by card_id" do
    runner =
      Netrunner.Mechanics.Discard.perform(
        %Netrunner.Runner{grip: ["sure_gamble"]},
        :grip,
        :heap,
        "sure_gamble"
      )

    assert runner.grip == []
    assert runner.heap == ["sure_gamble"]
  end

  test "discard a card that is not in hand" do
    runner =
      Netrunner.Mechanics.Discard.perform(
        %Netrunner.Runner{grip: []},
        :grip,
        :heap,
        "sure_gamble"
      )

    assert runner == {:error, :card_not_in_hand}
  end
end
