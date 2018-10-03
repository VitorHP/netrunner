defmodule Netrunner.Mechanics.If do
  def perform(target, nil) do
    { :ok, true }
  end

  def perform(target, params) do
    case verify_params(target, params) do
      [] ->
        { :ok, true }
      errors ->
        { :error, errors }
    end
  end

  defp verify_params(target, params) do
    Enum.reduce(
      params,
      [],
      fn { key, value }, acc ->
        Kernel.if target[key] >= value do
          acc
        else
          [key | acc]
        end
      end)
  end
end
