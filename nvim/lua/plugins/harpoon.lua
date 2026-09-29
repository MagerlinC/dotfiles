return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>H", function() require("harpoon"):list():add() end, desc = "Harpoon add mark" },
    { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon quick menu" },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon goto mark 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon goto mark 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon goto mark 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon goto mark 4" },
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon goto mark 5" },
  },
  config = function()
    require("harpoon"):setup()
  end,
}
