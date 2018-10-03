defmodule Netrunner.Mechanics do
  def install(subject, state, card, location) do
    with { :ok, player } <- Map.fetch(state, subject),
         { :ok, ticked } <- Netrunner.Mechanics.Tick.perform(player),
         { :ok, paid } <- Netrunner.Mechanics.Pay.perform(ticked, card),
         { :ok, installed } <- Netrunner.Mechanics.Install.perform(paid, card, location),
         { :ok, true } <- Netrunner.EventBus.register(card),
         { :ok, finished } <- Netrunner.EventBus.trigger(:install, installed, card) do
      { :ok, finished }
    else
      { :error, reasons } -> { :error, reasons }
    end
  end
end

