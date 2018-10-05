
defmodule Netrunner.Mechanics.DrawTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Draw

  test "draws a card" do
    runner = Netrunner.Mechanics.Draw.perform(%Netrunner.Runner{ grip: [], stack: [:card] }, :stack, :grip, 1)
    assert runner.grip == [:card]
    assert runner.stack == []
  end

  test "draws multiple cards" do
    runner = Netrunner.Mechanics.Draw.perform(%Netrunner.Runner{ grip: [], stack: [:card, :card, :card] }, :stack, :grip, 3)
    assert runner.grip == [:card, :card, :card]
    assert runner.stack == []
  end

  test "draws more cards than there are cards in the deck" do
    runner = Netrunner.Mechanics.Draw.perform(%Netrunner.Runner{ grip: [], stack: [:card, :card] }, :stack, :grip, 3)
    assert runner.grip == [:card, :card]
  end

end
