return {
  {
    "echasnovski/mini.animate",
    opts = function()
      local animate = require("mini.animate")
      return {
        open = { enable = false },
        close = { enable = false },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
      }
    end,
  },
}

