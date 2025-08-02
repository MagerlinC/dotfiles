return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		integrations = {
			blink_cmp = true,
			gitsigns = true,
			treesitter = true,
		},
		custom_highlights = function(colors)
			return {
				LineNrAbove = { fg = colors.overlay2 },
				LineNrBelow = { fg = colors.overlay2 },
			}
		end,
	},
}
