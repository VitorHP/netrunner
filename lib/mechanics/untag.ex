defmodule Netrunner.Mechanics.Untag do
  def perform(%{tags: tags} = _, amount) when amount > tags do
    {:error, :no_tags}
  end

  def perform(player, amount) do
    %{player | tags: player.tags - amount}
  end
end
