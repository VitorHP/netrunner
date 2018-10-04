defmodule Netrunner.Actions do
  alias Netrunner.Mechanics.Click, as: Click
  alias Netrunner.Mechanics.Pay, as: Pay
  alias Netrunner.Mechanics.Install, as: Install
  alias Netrunner.Mechanics.Profit, as: Profit
  alias Netrunner.Mechanics.Draw, as: Draw
  alias Netrunner.Mechanics.Shuffle, as: Shuffle
  alias Netrunner.Mechanics.Untag, as: Untag

  defdelegate card(card_id), to: Netrunner.Card, as: :by_id

  def setup(state) do
    runner = state.runner
      |> Profit.perform(5)
      |> Shuffle.perform(:stack)
      |> Draw.perform(:stack, :grip, 5)

    corp = state.corp
      |> Profit.perform(5)
      |> Shuffle.perform(:rnd)
      |> Draw.perform(:rnd, :hq, 5)

    %{ state | runner: runner, corp: corp }
  end

  def install(state, subject, card_id, location) do
    player = state
      |> Map.get(subject)
      |> Click.perform
      |> Pay.perform(card(card_id)["cost"])
      |> Install.perform(card(card_id), location)
      # |> Netrunner.Triggers.register(card),
      # |> Netrunner.Triggers.dispatch(:install, installed, card) do

    %{ state | subject => player }
  end

  def profit(state, subject) do
    player = state
      |> Map.get(subject)
      |> Click.perform
      |> Profit.perform(1)

    %{ state | subject => player }
  end

  def draw(state, subject, deck, hand) do
    player = state
      |> Map.get(subject)
      |> Click.perform
      |> Draw.perform(:stack, :grip, 1)

    %{ state | subject => player }
  end

  def untag(state) do
    player = state
      |> Map.get(:runner)
      |> Click.perform
      |> Pay.perform(2)
      |> Untag.perform(1)

    %{ state | runner: player }
  end

end

