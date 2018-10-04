defmodule Netrunner.Runner do
  defstruct credits: 0,
            clicks: 0,
            resources: [],
            programs: [],
            hardware: [],
            stack: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
            heap: [],
            grip: []
end
