defmodule Netrunner.Actions do
  alias Netrunner.Mechanics.Click, as: Click
  alias Netrunner.Mechanics.Pay, as: Pay
  alias Netrunner.Mechanics.Install, as: Install
  alias Netrunner.Mechanics.Profit, as: Profit
  alias Netrunner.Mechanics.Draw, as: Draw
  alias Netrunner.Mechanics.Shuffle, as: Shuffle

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

  def install(subject, state, card, location) do
    with { :ok, player } <- Map.fetch(state, subject),
         { :ok, clicked } <- Click.perform(player),
         { :ok, paid } <- Pay.perform(clicked, card),
         { :ok, installed } <- Install.perform(paid, card, location),
         { :ok, true } <- Netrunner.Triggers.register(card),
         { :ok, finished } <- Netrunner.Triggers.dispatch(:install, installed, card) do
      { :ok, finished }
    else
      { :error, reasons } -> { :error, reasons }
    end
  end

  def profit(subject, state) do
    with { :ok, player } <- Map.fetch(state, subject),
         { :ok, clicked } <- Click.perform(player),
         { :ok, profitted } <- Profit.perform(clicked, %{ profit: 1 }) do
      { :ok, profitted }
    else
      { :error, reasons } -> { :error, reasons }
    end
  end

  def draw(subject, state, deck) do
    with { :ok, player } <- Map.fetch(state, subject),
         { :ok, clicked } <- Click.perform(player),
         { :ok, drawn } <- Draw.perform(clicked, deck, 1) do
      { :ok, drawn }
    else
      { :error, reasons } -> { :error, reasons }
    end
  end

  def discard(subject, state) do
  end
end

