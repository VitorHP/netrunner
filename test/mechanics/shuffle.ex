defmodule Netrunner.Mechanics.ShuffleTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Shuffle

  test "empty params" do
    assert Netrunner.Mechanics.Shuffle.perform(%{ stack: [1, 2, 3] }, :stack) !== %{ stack: [1, 2, 3] }
  end

end
