defmodule Netrunner.Actions do
  @players [:runner, :corp]

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

  # def new_turn(%__MODULE__{turns: []} = game) do
  #   %{game | turns: [%Turn{player: :corp}]}
  # end

  # def new_turn(%__MODULE__{turns: [last_turn | turns]} = game) do
  #   %{game | turns: [%Turn{player: new_turn_player(last_turn)} | game.turns]}
  # end

  # defp new_turn_player(last_turn) do
  #   Enum.find(@players, fn x -> x !== last_turn.player end)
  # end

  def dispatch(state, action) do
    %{
      runner: __MODULE__.runner(state.runner, action),
      corp: __MODULE__.corp(state.corp, action),
      issues: __MODULE__.issues(state.issues, action),
      triggers: __MODULE__.triggers(state.triggers, action)
    }
  end

  def runner(runner, { kind, %{ target: :runner } } = action) do
    case kind do
      :setup ->
        runner
          |> Profit.perform(5)
          |> Shuffle.perform(:stack)
          |> Draw.perform(:stack, :grip, 5)
      _ ->
        __MODULE__.player(runner, action)
    end
  end

  def runner(runner, _) do
    runner
  end

  def corp(corp, { kind, %{ target: :corp } } = action) do
    case kind do
      :setup ->
        corp
          |> Profit.perform(5)
          |> Shuffle.perform(:rnd)
          |> Draw.perform(:rnd, :hq, 5)
      _ ->
        __MODULE__.player(corp, action)
    end
  end

  def corp(corp, _) do
    corp
  end

  def player(player, { kind, payload } = action) do
    case kind do
      :install ->
        player
          |> Click.perform()
          |> Pay.perform(card(payload.card_id).cost)
          |> Install.perform(card(payload.card_id), payload.location)
      :profit ->
        player
          |> Click.perform()
          |> Profit.perform(1)
      :draw ->
        player
          |> Click.perform()
          |> Draw.perform(payload.deck, payload.hand, 1)
      :untag ->
        player
          |> Click.perform()
          |> Pay.perform(2)
          |> Untag.perform(1)
      :play ->
        player
          |> Click.perform()
          |> Pay.perform(card(payload.card_id).cost)
          |> apply_effects(card(payload.card_id))
          |> Discard.perform(:grip, :heap, payload.card_id)
      _ ->
        player
    end
  end

  def issues(issues, { kind, _ } = _) do
    case kind do
      :setup ->
        issues
          |> Issue.perform(:runner, [%{target: :runner, mulligan: true}, %{no_op: true}])
          |> Issue.perform(:corp, [%{target: :corp, mulligan: true}, %{no_op: true}])
      _ ->
        issues
    end
  end

  def triggers(triggers, { kind, payload } = _) do
    case kind do
      :install ->
        triggers
          |> Netrunner.Trigger.register(payload.target, card(payload.card_id))
      _ ->
        triggers
    end
  end

  defp apply_effects(player, card) do
    card
      |> Map.get(:play)
      |> Map.take(effects())
      |> Enum.reduce(player, fn {key, value}, acc ->
        apply(
          String.to_existing_atom("Elixir.Netrunner.Mechanics." <> String.capitalize(key)),
          :perform,
          [acc, value]
        )
      end)
  end

  defp effects do
    [:profit]
  end
end
