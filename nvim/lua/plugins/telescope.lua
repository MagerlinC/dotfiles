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
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),
				},
			},
		})
		require("telescope").load_extension("cmdline")
		require("telescope").load_extension("ui-select")
	end,
}
