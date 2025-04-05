local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			question_header = "## Mikkel",
			answer_header = "## Copilot ",
			error_header = "## Error ",
			-- model = "claude-3.7-sonnet",
			prompts = prompts,
		},
		event = "VeryLazy",
	},
}
