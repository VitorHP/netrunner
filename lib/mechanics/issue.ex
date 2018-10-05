defmodule Netrunner.Mechanics.Issue do
  def perform(state, target, options) do
    %{ state | issues: [%{ target: target, options: options } | state.issues] }
  end
end
