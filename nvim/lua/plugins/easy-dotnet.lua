return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'folke/snacks.nvim', },
  config = function()
    local dotnet = require("easy-dotnet")
    -- Options are not required
    dotnet.setup({
      server = {
        log_level = "Verbose",
      },
      lsp = {
        enabled = true,                      -- Enable builtin roslyn lsp
        preload_roslyn = true,               -- Start loading roslyn before any buffer is opened
        roslynator_enabled = true,           -- Automatically enable roslynator analyzer
        easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
        auto_refresh_codelens = true,
        analyzer_assemblies = {},            -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
        config = {},
      },
      picker = "snacks",
    })

    -- Example keybinding
    vim.keymap.set("n", "<C-p>", function()
      dotnet.run()
    end)
  end
}
