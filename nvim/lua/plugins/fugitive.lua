return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gf", ":G fresh<CR>", desc = "Git fresh" },
    { "<leader>gmd", ":G merge origin dev<CR>", desc = "Git merge dev" },
    { "<leader>gs", ":G<CR>", desc = "Git status" },
    { "<leader>ga", ":G add . <CR>", desc = "Git add all" },
    { "<leader>gc", ":G commit<CR>", desc = "Git commit" },
    { "<leader>gp", ":G push<CR>", desc = "Git push" },
    { "<leader>gpl", ":G pull<CR>", desc = "Git pull" },
  },
}
