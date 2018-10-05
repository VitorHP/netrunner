defmodule Netrunner.Mechanics.UntagTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Untag

  test "Removes a tag" do
    runner = Netrunner.Mechanics.Untag.perform(%{tags: 5}, 1)
    assert runner.tags == 4
  end

  test "removing when no tags" do
    assert Netrunner.Mechanics.Untag.perform(%{tags: 0}, 2) == {:error, :no_tags}
  end
end
