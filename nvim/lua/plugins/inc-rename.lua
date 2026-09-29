return {
  "smjonas/inc-rename.nvim",
  keys = {
    { "<leader>cr", function() return ":IncRename " .. vim.fn.expand("<cword>") end, expr = true, desc = "LSP Rename" },
  },
  opts = {},
}
