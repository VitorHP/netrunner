defmodule Netrunner.Mechanics.DiscardTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Discard

  test "discard by card_id" do
    runner =
      Netrunner.Mechanics.Discard.perform(
        %Netrunner.Runner{hand: ["sure_gamble"]},
        :hand,
        :discard,
        "sure_gamble"
      )

    assert runner.hand == []
    assert runner.discard == ["sure_gamble"]
  end

  test "discard a card that is not in hand" do
    runner =
      Netrunner.Mechanics.Discard.perform(
        %Netrunner.Runner{hand: []},
        :hand,
        :discard,
        "sure_gamble"
      )

    assert runner == {:error, :card_not_in_hand}
  end
end
