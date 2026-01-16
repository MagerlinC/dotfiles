return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'folke/snacks.nvim', },
  config = function()
    local dotnet = require("easy-dotnet")
    -- Options are not required
    dotnet.setup({
      lsp = {
        enabled = true,            -- Enable builtin roslyn lsp
        roslynator_enabled = true, -- Automatically enable roslynator analyzer
        analyzer_assemblies = {},  -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
        config = {},
      },
      debugger = {
        -- Path to custom coreclr DAP adapter
        -- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
        bin_path = nil,
        apply_value_converters = true,
        auto_register_dap = true,
        mappings = {
          open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
        },
      },
      picker = "snacks",
    })

    -- Example keybinding
    vim.keymap.set("n", "<C-p>", function()
      dotnet.run()
    end)
  end
}
