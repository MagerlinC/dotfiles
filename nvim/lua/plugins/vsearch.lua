return {
	dir = "~/plugins/vsearch.nvim/",
	config = function()
		require("vsearch").setup({
			keymap = "<leader>vs",
		})
	end,
}
