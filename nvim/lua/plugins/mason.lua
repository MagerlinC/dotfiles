return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      --		"csharp_ls", testing out easy-dotnet
      "yamlls",
      "gh_actions_ls",
      "vtsls",
      "eslint",
      "lua_ls",
      "jsonls",
      "html",
      "dockerls",
      "bashls",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
