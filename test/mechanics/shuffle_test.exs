defmodule Netrunner.Mechanics.ShuffleTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Shuffle

  test "empty params" do
    assert Netrunner.Mechanics.Shuffle.perform(%{deck: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]}, :deck) !==
             %{deck: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]}
  end
end
