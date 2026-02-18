return {
  "carlos-algms/agentic.nvim",
  opts = {
    -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp"
    provider = "claude-acp", -- setting the name here is all you need to get started
  },
  -- these are just suggested keymaps; customize as desired
  keys = {
    {
      "<leader>ac",
      function() require("agentic").toggle() end,
      mode = { "n", "v" },
      desc = "Toggle Agentic Chat"
    },
    {
      "<leader>aa",
      function() require("agentic").add_selection_or_file_to_context() end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context"
    },
    {
      "<leader>an",
      function() require("agentic").new_session() end,
      mode = { "n", "v" },
      desc = "New Agentic Session"
    },
    {
      "<leader>ar", -- ai Restore
      function()
        require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v", },
    },
  },
}
