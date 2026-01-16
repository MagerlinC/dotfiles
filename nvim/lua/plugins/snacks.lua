return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {},
    image = {},
  },
  keys = {
    {
      "<leader><leader>",
      function()
        Snacks.picker.files({
          cwd = vim.fn.getcwd(),
        })
      end,
      desc = "Find Files"
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep({
          cwd = vim.fn.getcwd(),
        })
      end,
      desc = "Grep"
    },
    { "<leader>vs", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
  }
}
