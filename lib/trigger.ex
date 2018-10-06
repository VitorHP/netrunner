defmodule Netrunner.Trigger do
  def register(triggers, target, card) do
    Map.merge(triggers, build_triggers(target, card), fn _k, v1, v2 ->
      Enum.concat(v1, v2)
    end)
  end

  def build_triggers(target, card) do
    card
      |> Map.take(triggers())
      |> Enum.reduce(%{}, fn {trigger, effects}, acc ->
        Map.put(
          acc,
          trigger,
          Enum.map(effects, &Map.merge(&1, %{target: target, origin: Map.get(card, :id)}))
        )
      end)
  end

  defp triggers do
    [:start_turn]
  end
end
