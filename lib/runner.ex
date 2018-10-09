defmodule Netrunner.Runner do
  defstruct credits: 0,
            clicks: 0,
            tags: 0,
            memory: 4,
            resources: [],
            programs: [],
            hardware: [],
            deck: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
            discard: [],
            hand: [],
            identity: nil
end
