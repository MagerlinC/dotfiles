return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["gb"] = { "actions.parent", mode = "n" },
      ["<C-p>"] = {
        "actions.preview",
        opts = {
          vertical = true,
          split = "belowright",
        },
      },
    },
    -- Configuration for the file preview window
    preview_win = {
      -- Whether the preview window is automatically updated when the cursor is moved
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      split = "belowright",
      -- A function that returns true to disable preview on a file e.g. to avoid lag
      disable_preview = function(filename)
        return false
      end,
    },
    win_options = {
      winbar = "%{v:lua.require('oil').get_current_dir()}",
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
