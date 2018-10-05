defmodule Netrunner.Mechanics.InstallTest do
  use ExUnit.Case
  doctest Netrunner.Mechanics.Install

  test "install a resource card" do
    runner =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Runner{},
        %{kind: "resource", id: "test"},
        :rig
      )

    assert runner.resources == ["test"]
  end

  test "install a program card" do
    runner =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Runner{},
        %{kind: "program", id: "test"},
        :rig
      )

    assert runner.programs == ["test"]
  end

  test "install a hardware card" do
    runner =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Runner{},
        %{kind: "hardware", id: "test"},
        :rig
      )

    assert runner.hardware == ["test"]
  end

  test "install an ice card on HQ" do
    corp = Netrunner.Mechanics.Install.perform(%Netrunner.Corp{}, %{kind: "ice", id: "chum"}, :hq)
    assert corp.ice.hq == ["chum"]
  end

  test "install an ice card on R&D" do
    corp =
      Netrunner.Mechanics.Install.perform(%Netrunner.Corp{}, %{kind: "ice", id: "chum"}, :rnd)

    assert corp.ice.rnd == ["chum"]
  end

  test "install an ice card on Archives" do
    corp =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Corp{},
        %{kind: "ice", id: "chum"},
        :archives
      )

    assert corp.ice.archives == ["chum"]
  end

  test "install an ice card in External Server" do
    corp = Netrunner.Mechanics.Install.perform(%Netrunner.Corp{}, %{kind: "ice", id: "chum"}, 0)
    assert Map.get(corp.ice, 0) == ["chum"]
  end

  test "install an agenda in External Server" do
    corp =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Corp{},
        %{kind: "agenda", id: "nisei_mk_ii"},
        0
      )

    assert Map.get(corp.servers, 0) == ["nisei_mk_ii"]
  end

  test "install an asset in External Server" do
    corp =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Corp{},
        %{kind: "asset", id: "project_junebug"},
        0
      )

    assert Map.get(corp.servers, 0) == ["project_junebug"]
  end

  test "install an agenda in a full External Server" do
    corp =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Corp{servers: %{0 => ["project_junebug"]}},
        %{kind: "agenda", id: "nisei_mk_ii"},
        0
      )

    assert corp == {:error, :server_full}
  end

  test "install an upgrage in External Server" do
    corp =
      Netrunner.Mechanics.Install.perform(
        %Netrunner.Corp{},
        %{kind: "upgrade", id: "akitaro_watanabe"},
        0
      )

    assert Map.get(corp.upgrades, 0) == ["akitaro_watanabe"]
  end
end
