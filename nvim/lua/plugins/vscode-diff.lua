return {
  "esmuellert/codediff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  config = function()
    require("vscode-diff").setup({
      -- Keymaps in diff view
      keymaps = {
        view = {
          quit = "q",                    -- Close diff tab
          toggle_explorer = "<leader>e", -- Toggle explorer visibility (explorer mode only)
          next_hunk = "<leader>nc",      -- Jump to next change
          prev_hunk = "<leader>pc",      -- Jump to previous change
          next_file = "<leader>nf",      -- Next file in explorer mode
          prev_file = "<leader>pf",      -- Previous file in explorer mode
          -- Choose theirs
          diff_get = "<leader>ct",       -- Get change from other buffer (like vimdiff)
          -- Choose ours
          diff_put = "<leader>co",       -- Put change to other buffer (like vimdiff)
        },
        explorer = {
          select = "<CR>",        -- Open diff for selected file
          hover = "K",            -- Show file diff preview
          refresh = "R",          -- Refresh git status
          toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
        },
      },
    })
  end,
}
