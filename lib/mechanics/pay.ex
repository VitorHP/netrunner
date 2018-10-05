defmodule Netrunner.Mechanics.Pay do
  def perform(%{credits: credits} = _, value) when value > credits do
    {:error, :no_credits}
  end

  def perform(player, value) do
    %{player | credits: player.credits - value}
  end
end
