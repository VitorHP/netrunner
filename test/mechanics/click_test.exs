defmodule Netrunner.Mechanics.ClickTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Click

  test "decreases player tick" do
    runner = Netrunner.Mechanics.Click.perform(%Netrunner.Runner{clicks: 1})
    assert runner.clicks == 0
  end

  test "clicks when no click" do
    assert Netrunner.Mechanics.Click.perform(%Netrunner.Runner{clicks: 0}) == {:error, :no_clicks}
  end
end
