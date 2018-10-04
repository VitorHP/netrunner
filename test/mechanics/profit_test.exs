
defmodule Netrunner.Mechanics.ProfitTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Profit

  test "gains credits" do
    runner = Netrunner.Mechanics.Profit.perform(%{ credits: 5 }, 3)
    assert runner.credits == 8
  end

end
