defmodule Netrunner.Corp do
  defstruct credits: 0,
            clicks: 0,
            servers: [],
            deck: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
            discard: [],
            hand: [],
            ice: %{},
            servers: %{},
            upgrades: %{}
end
