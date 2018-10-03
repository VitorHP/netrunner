defmodule Netrunner.Mechanics.InstallTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Install

  test "install a resource card" do
    runner = Netrunner.Mechanics.Install.perform(%{ resources: [] }, %{ kind: 'resource', name: 'test' }, :rig)
    assert runner[:resources] == [%{kind: 'resource', name: 'test'}]
  end

  test "install a program card" do
    runner = Netrunner.Mechanics.Install.perform(%{ programs: [] }, %{ kind: 'program', name: 'test' }, :rig)
    assert runner[:programs] == [%{kind: 'program', name: 'test'}]
  end

  test "install a hardware card" do
    runner = Netrunner.Mechanics.Install.perform(%{ hardware: [] }, %{ kind: 'hardware', name: 'test' }, :rig)
    assert runner[:hardware] == [%{kind: 'hardware', name: 'test'}]
  end

end
