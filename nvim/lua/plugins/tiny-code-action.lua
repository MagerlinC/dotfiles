return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  event = "LspAttach",
  opts = {
    picker = {
      "buffer",
      opts = {
        hotkeys = true,               -- Enable hotkeys for quick selection of actions
        hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
        auto_preview = false,         -- Enable or disable automatic preview
        auto_accept = true,           -- Automatically accept the selected action
        position = "cursor",          -- Position of the picker window
        winborder = "rounded",        -- Border style for picker and preview windows
      },
    },
  },
}
