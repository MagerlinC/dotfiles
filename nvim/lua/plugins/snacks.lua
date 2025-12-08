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
  }
}
