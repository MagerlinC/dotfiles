local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Eslint on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	command = "silent! EslintFixAll",
	group = vim.api.nvim_create_augroup("MyAutocmdsJavaScripFormatting", {}),
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

require("magerlin.globals")
require("magerlin.mappings")
require("magerlin.options")

vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd("hi IlluminatedWordText guibg=none gui=underline")
vim.cmd("hi IlluminatedWordRead guibg=none gui=underline")
vim.cmd("hi IlluminatedWordWrite guibg=none gui=underline")

require("nvim-highlight-colors").setup({
	enable_named_colors = false,
})

require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		csharp = { "csharpier", lsp_format = "fallback" },
	},
})

require("lualine").setup({
	options = {
		theme = "catppuccin",
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "fileformat", "filetype" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})

require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
})

-- Nvim DAP
local dap = require("dap")
local dapui = require("dapui")
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

-- Nvim DAP UI
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Diffview
local actions = require("diffview.actions")
require("diffview").setup({
	keymaps = {
		{
			"n",
			"<leader>nc",
			actions.prev_conflict,
			{ desc = "In the merge-tool: jump to the previous conflict" },
		},
		{
			"n",
			"<leader>pc",
			actions.next_conflict,
			{ desc = "In the merge-tool: jump to the next conflict" },
		},
	},
	file_panel = {
		listing_style = "tree", -- One of 'list' or 'tree'
		tree_options = { -- Only applies when listing_style is 'tree'
			flatten_dirs = true, -- Flatten dirs that only contain one single dir
			folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
		},
		win_config = {
			position = "left",
			width = 45,
			win_opts = {},
		},
	},
})

-- Copilot chat

-- Copilot chat
local chat = require("CopilotChat")
local select = require("CopilotChat.select")
chat.setup({
	model = "claude-3.7-sonnet",
	references_display = "write",
	debug = false,
	question_header = "Mikkel",
	selection = select.visual,
	context = "buffers",
	mappings = {
		reset = false,
		show_diff = {
			full_diff = true,
		},
	},
})
