defmodule Netrunner.Mechanics.Issue do
  def perform(issues, target, options) do
    [%{target: target, options: options} | issues]
  end
end
