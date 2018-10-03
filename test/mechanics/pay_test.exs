defmodule Netrunner.Mechanics.PayTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Pay

  test "pays with credits" do
    runner = Netrunner.Mechanics.Pay.perform(%{ credits: 5 }, %{ cost: 3 })
    assert runner[:credits] == 2
  end

end
