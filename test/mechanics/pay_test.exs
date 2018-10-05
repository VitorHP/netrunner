defmodule Netrunner.Mechanics.PayTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Pay

  test "pays with credits" do
    runner = Netrunner.Mechanics.Pay.perform(%{credits: 5}, 3)
    assert runner.credits == 2
  end

  test "pays when not enough credits" do
    assert Netrunner.Mechanics.Pay.perform(%{credits: 2}, 3) == {:error, :no_credits}
  end
end
