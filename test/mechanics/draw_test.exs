defmodule Netrunner.Mechanics.DrawTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Draw

  test "draws a card" do
    runner =
      Netrunner.Mechanics.Draw.perform(
        %Netrunner.Runner{hand: [], deck: [:card]},
        :deck,
        :hand,
        1
      )

    assert runner.hand == [:card]
    assert runner.deck == []
  end

  test "draws multiple cards" do
    runner =
      Netrunner.Mechanics.Draw.perform(
        %Netrunner.Runner{hand: [], deck: [:card, :card, :card]},
        :deck,
        :hand,
        3
      )

    assert runner.hand == [:card, :card, :card]
    assert runner.deck == []
  end

  test "draws more cards than there are cards in the deck" do
    runner =
      Netrunner.Mechanics.Draw.perform(
        %Netrunner.Runner{hand: [], deck: [:card, :card]},
        :deck,
        :hand,
        3
      )

    assert runner.hand == [:card, :card]
  end
end
