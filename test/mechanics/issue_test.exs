defmodule Netrunner.Mechanics.IssueTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Draw

  test "creates an issue" do
    issues =
      Netrunner.Mechanics.Issue.perform([], :runner, [
        %{profit: 1},
        {:draw, :deck, :hand, 1}
      ])

    assert issues == [%{target: :runner, options: [%{profit: 1}, {:draw, :deck, :hand, 1}]}]
  end
end
