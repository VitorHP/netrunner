defmodule Netrunner.Mechanics.IfTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.If

  test "empty params" do
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{}, nil) == { :ok, true }
  end

  test "checks one key" do
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{ credits: 5 }, %{ credits: 1 }) == { :ok, true }
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{ credits: 5 }, %{ credits: 6 }) == { :error, [:credits] }
  end

  test "checks multiple keys" do
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{ credits: 5, memory: 2}, %{ credits: 1, memory: 1 }) == { :ok, true }
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{ credits: 5, memory: 2 }, %{ credits: 6, memory: 1 }) == { :error, [:credits] }
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{ credits: 5, memory: 2 }, %{ credits: 1, memory: 3 }) == { :error, [:memory] }
    assert Netrunner.Mechanics.If.perform(%Netrunner.Runner{ credits: 5, memory: 2 }, %{ credits: 6, memory: 3 }) == { :error, [:memory, :credits] }
  end
end
