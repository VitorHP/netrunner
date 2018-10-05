defmodule Netrunner.Mechanics.Click do
  def perform(_, _ \\ 1)

  def perform(%{clicks: 0} = _, _) do
    {:error, :no_clicks}
  end

  def perform(player, amount) do
    %{player | clicks: player.clicks - amount}
  end
end
