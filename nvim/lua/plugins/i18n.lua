return {
	"magerlinc/i18n.nvim",
	config = function()
		require("i18n").setup({
			creationKeymap = "<leader>gl",
			creationCmd = "yarn genlabel",
			langs = {
				{
					filePath = "~/git/Cirrus/frontend/localization/en.json",
					keymap = "<leader>g1",
				},
				{
					filePath = "~/git/Cirrus/frontend/localization/da.json",
					keymap = "<leader>g2",
				},
			},
		})
	end,
}
