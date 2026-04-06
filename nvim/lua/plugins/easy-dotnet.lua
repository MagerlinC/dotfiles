return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "folke/snacks.nvim",
  },
  config = function()
    local dotnet = require("easy-dotnet")
    dotnet.setup({
      lsp = {
        enabled = true,
        preload_roslyn = true,
        roslynator_enabled = true,
        easy_dotnet_analyzer_enabled = true,
        auto_refresh_codelens = true,
        analyzer_assemblies = {},
        config = {},
      },
      debugger = {
        auto_register_dap = true,
        console = "integratedTerminal",
      },
      test_runner = {
        viewmode = "float",
      },
      picker = "snacks",
    })

    -- Register .NET specific DAP variables viewer
    require("easy-dotnet.netcoredbg").register_dap_variables_viewer()

    vim.keymap.set("n", "<C-p>", dotnet.run, { desc = "Dotnet run" })
    vim.keymap.set("n", "<leader>Dt", "<cmd>Dotnet testrunner<CR>", { desc = "Dotnet test runner" })
    vim.keymap.set("n", "<leader>Dr", "<cmd>Dotnet testrunner refresh<CR>", { desc = "Dotnet test runner refresh" })
    vim.keymap.set("n", "<leader>Dd", dotnet.debug, { desc = "Dotnet debug" })
    vim.keymap.set("n", "<leader>DD", dotnet.debug_default, { desc = "Dotnet debug (default)" })
  end,
}
