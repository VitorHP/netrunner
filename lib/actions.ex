defmodule Netrunner.Actions do
  alias Netrunner.Runner, as: Runner
  alias Netrunner.Corp, as: Corp

  alias Netrunner.Mechanics.Click, as: Click
  alias Netrunner.Mechanics.Pay, as: Pay
  alias Netrunner.Mechanics.Install, as: Install
  alias Netrunner.Mechanics.Profit, as: Profit
  alias Netrunner.Mechanics.Draw, as: Draw
  alias Netrunner.Mechanics.Shuffle, as: Shuffle
  alias Netrunner.Mechanics.Untag, as: Untag
  alias Netrunner.Mechanics.Discard, as: Discard
  alias Netrunner.Mechanics.Issue, as: Issue

  defdelegate card(card_id), to: Netrunner.Card, as: :by_id

  def setup(state) do
    state
    |> Map.put(:runner,
      state.runner
        |> Profit.perform(5)
        |> Shuffle.perform(:stack)
        |> Draw.perform(:stack, :grip, 5)
    )
    |> Map.put(:corp,
      state.corp
        |> Profit.perform(5)
        |> Shuffle.perform(:rnd)
        |> Draw.perform(:rnd, :hq, 5)
    )
    |> Issue.perform(:runner, [%{ target: :runner, mulligan: true}, %{ no_op: true }])
    |> Issue.perform(:corp, [%{ target: :corp, mulligan: true}, %{ no_op: true }])
  end

  def install(state, :runner = target, card_id, location) do
    player = state
      |> Map.get(target)
      |> Click.perform
      |> Pay.perform(card(card_id).cost)
      |> Install.perform(card(card_id), location)
      |> Netrunner.Trigger.register(target, card(card_id))
      # |> Netrunner.Triggers.dispatch(:install, installed, card) do

    %{ state | target => player }
  end

  def profit(state, target) do
    player = state
      |> Map.get(target)
      |> Click.perform()
      |> Profit.perform(1)

    %{ state | target => player }
  end

  def draw(state, target, deck, hand) do
    player = state
      |> Map.get(target)
      |> Click.perform()
      |> Draw.perform(deck, hand, 1)

    %{ state | target => player }
  end

  def untag(state) do
    player = state
      |> Map.get(:runner)
      |> Click.perform()
      |> Pay.perform(2)
      |> Untag.perform(1)

    %{ state | runner: player }
  end

  def play(state, target, card_id) do
    state
      |> Map.get(target)
      |> Click.perform()
      |> Pay.perform(card(card_id).cost)
      |> apply_effects(card(card_id))
      |> Discard.perform(:grip, :heap, card_id)
  end

  defp apply_effects(state, card) do
    card
      |> Map.get(:play)
      |> Map.take(effects())
      |> Enum.reduce(state, fn { key, value }, acc ->
        apply(String.to_existing_atom("Elixir.Netrunner.Mechanics." <> String.capitalize(key)), :perform, [acc, value])
      end)
  end

  defp effects do
    [:profit]
  end
end
