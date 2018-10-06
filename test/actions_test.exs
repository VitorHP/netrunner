defmodule Netrunner.ActionsTest do
  use ExUnit.Case
  doctest Netrunner.Actions

  describe "setup" do
    setup do
      {
        :ok,
        game: Netrunner.Actions.dispatch( Netrunner.Game.build, { :setup, %{ target: :runner } })
      }
    end

    test "cards", context do
      assert length(context.game.runner.grip) == 5
    end

    test "credits", context do
      assert context.game.runner.credits == 5
    end

    test "mulligans", context do
      assert length(context.game.issues) == 2
    end
  end

  describe "install" do
    setup do
      game = %{ Netrunner.Game.build |
        runner: %Netrunner.Runner{
          grip: ["cyberfeeder"],
          clicks: 1,
          credits: 2
        }
      }

      { :ok, game: Netrunner.Actions.dispatch(game, { :install, %{ target: :runner, card_id: "cyberfeeder", location: :rig } }) }
    end

    test "charges click", context do
      assert context.game.runner.clicks == 0
    end

    test "charges cost", context do
      assert context.game.runner.credits == 0
    end

    test "installs the card", context do
      assert length(context.game.runner.hardware) == 1
    end

    test "registers triggers", context do
      assert length(context.game.triggers.start_turn) == 1
    end

    # test "calls install trigger"
  end
end
