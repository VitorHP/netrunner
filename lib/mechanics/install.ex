defmodule Netrunner.Mechanics.Install do
  def perform(_, nil, _), do: {:error, :no_card}

  def perform(player, %{kind: "resource", id: id} = _, _) do
    add_to_rig(player, :resources, id)
  end

  def perform(player, %{kind: "program", id: id} = _, _) do
    add_to_rig(player, :programs, id)
  end

  def perform(player, %{kind: "hardware", id: id} = _, _) do
    add_to_rig(player, :hardware, id)
  end

  def perform(player, %{kind: "ice"} = card, location) do
    add_to_corp(player, :ice, card, location)
  end

  def perform(player, %{kind: kind} = card, location)
      when (kind == "agenda" or kind == "asset") and is_integer(location) do
    case Map.get(player.servers, location) do
      nil ->
        add_to_corp(player, :servers, card, location)

      _ ->
        {:error, :server_full}
    end
  end

  def perform(player, %{kind: "upgrade"} = card, location) do
    add_to_corp(player, :upgrades, card, location)
  end

  defp add_to_rig(runner, rig_section, card_id) do
    %{runner | rig_section => [card_id | Map.get(runner, rig_section)]}
  end

  defp add_to_corp(corp, section, card, location) do
    ice =
      case corp
           |> Map.get(section)
           |> Map.get(location) do
        nil ->
          %{location => [card.id]}

        ice ->
          %{location => [card.id | ice]}
      end

    %{corp | section => ice}
  end
end
