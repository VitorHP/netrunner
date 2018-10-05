
defmodule Netrunner.Mechanics.IssueTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Draw

  test "creates an issue" do
    game = Netrunner.Mechanics.Issue.perform(%Netrunner.Game{}, :runner, [%{ profit: 1 }, { :draw, :stack, :grip, 1 }])
    assert game.issues == [%{ target: :runner, options: [%{ profit: 1 }, { :draw, :stack, :grip, 1 }]}]
  end

end
