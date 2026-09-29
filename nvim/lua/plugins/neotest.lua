return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "nvim-neotest/neotest-jest",
    "thenbe/neotest-playwright",
  },
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run all tests in file" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        }),
        -- require("neotest-jest")({
        --   jestCommand = "npm test --",
        --   jestConfigFile = "jest/jest.config.ts",
        --   env = { CI = true },
        --   cwd = function(path)
        --     return vim.fn.getcwd()
        --   end,
        --   root = function(path)
        --     -- Check for specific project path or markers
        --     if string.match(path, "~/git/foundation") then
        --       return vim.fn.getcwd()
        --     end
        --     return nil -- Return nil to skip this adapter for other projects
        --   end,
        -- }),
      },
    })
  end,
}
