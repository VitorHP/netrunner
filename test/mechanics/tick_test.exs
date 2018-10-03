
defmodule Netrunner.Mechanics.TickTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Tick

  test "decreases player tick" do
    runner = Netrunner.Mechanics.Tick.perform(%{ tick: 1 })
    assert runner[:tick] == 0
  end

end
