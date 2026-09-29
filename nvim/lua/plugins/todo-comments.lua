return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>nt", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
		{ "<leader>pt", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
	},
	opts = {},
}
