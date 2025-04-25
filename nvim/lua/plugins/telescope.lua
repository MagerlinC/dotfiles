return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jonarrien/telescope-cmdline.nvim",
	},
	config = function(_, opts)
		require("telescope").setup({
			unpack(opts),
		})
		require("telescope").load_extension("cmdline")
	end,
}
