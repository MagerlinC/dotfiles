local map = vim.keymap.set
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Splitting
map("n", "<leader>-", ":split<CR>", { desc = "split horizontal" })
map("n", "<leader>|", ":vsplit<CR>", { desc = "split vertical" })

-- source keymaps
map("n", "<leader>cc", ":source ~/.config/nvim/lua/mappings.lua<CR>", { desc = "source keymaps" })

-- General mapping
map("n", "gb", "<C-o>", { silent = true, desc = "Go back" })
map("n", "gi", vim.lsp.buf.implementation, { silent = true, desc = "Go to implementation" })

-- Visual mode move lines
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected lines up" })

-- Keep cursor in middle while going up/down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Clipboard saving paste/delete
map("x", "<leader>p", '"_dP', { silent = true, desc = "Paste over keeping clipboard" })
map("n", "<leader>d", '"_d', { silent = true, desc = "Delete keeping clipboard" })
map("v", "<leader>d", '"_d', { silent = true, desc = "Delete keeping clipboard" })

-- Dont die on Q
map("n", "Q", "<nop>")

-- Git
map("n", "<leader>gb", ":GitBlameToggle<CR>", { silent = true, desc = "Git blame" })

-- Hop
-- local hop = require("hop")
-- local directions = require("hop.hint").HintDirection
-- map("", "<leader>hw", function()
-- 	hop.hint_words()
-- end, { desc = "Hop word" })
-- map("", "f", function()
-- 	hop.hint_char1({ direction = directions.after_cursor, current_line_only = true })
-- end, { remap = true })
-- map("", "f", function()
-- 	hop.hint_char1({ direction = directions.before_cursor, current_line_only = true })
-- end, { remap = true })
-- map("", "t", function()
-- 	hop.hint_char1({ direction = directions.after_cursor, current_line_only = true, hint_offset = -1 })
-- end, { remap = true })
-- map("", "T", function()
-- 	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, { remap = true })

-- Navigate buffers
map("n", "<leader>bd", ":bd<CR>", { desc = "close current buffer" })

map("n", "<leader>bo", ":%bd|e#<CR>", { silent = true, desc = "Close all buffers except current" })

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
map(
	"n",
	"<leader>hf",
	"<cmd>:Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>",
	{ desc = "Telescope find hidden files" }
)
map("n", "<leader>sg", builtin.live_grep, { desc = "Telescope search global" })
map("n", "<leader>sgb", builtin.git_branches, { desc = "Telescope search git branches" })
map("n", "<leader>sb", builtin.buffers, { desc = "Telescope search buffers" })
map("n", "<leader>fr", builtin.lsp_references, { desc = "Find references" })

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

map("n", "<leader>H", function()
	harpoon:list():add()
end)
map("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<leader>1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon goto mark 1" })
map("n", "<leader>2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon goto mark 2" })
map("n", "<leader>3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon goto mark 3" })
map("n", "<leader>4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon goto mark 4" })
map("n", "<leader>5", function()
	harpoon:list():select(5)
end, { desc = "Harpoon goto mark 5" })

-- NeoTest
map("n", "<leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })

map("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run all tests in file" })

map("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "toggle test summary" })

map("n", "<leader>to", function()
	require("neotest").output_panel.toggle()
end, { desc = "toggle output panel" })

-- Oil
map("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open Oil" })

-- Noice
map("n", "<leader>nc", "<CMD>NoiceDismiss<CR>", { desc = "Dismiss notifications" })

-- Fugitive
map("n", "<leader>gf", ":G fresh<CR>", { desc = "Git fresh" })
map("n", "<leader>gmd", ":G merge origin dev<CR>", { desc = "Git merge dev" })
map("n", "<leader>gs", ":G<CR>", { desc = "Git status" })
map("n", "<leader>ga", ":G add . <CR>", { desc = "Git add all" })
map("n", "<leader>gc", ":G commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", ":G push<CR>", { desc = "Git push" })
map("n", "<leader>gpl", ":G pull<CR>", { desc = "Git pull" })

-- Barbar
map("n", "<leader>bp", ":BufferPick<CR>", { desc = "Buffer 1" })
map("n", "L", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "H", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })

-- Easy-dotnet
map("n", "<leader>dnr", ":lua require('easy-dotnet').run()<CR>", { desc = "Run dotnet" })

-- Nvim DAP
map("n", "<leader>db", "<cmd>:DapToggleBreakpoint<CR>", { desc = "DAP toggle breakpoint" })
map("n", "<leader>ds", "<cmd>:DapStepOver<CR>", { desc = "DAP Step Over" })
map("n", "<leader>dc", "<cmd>:DapContinue<CR>", { desc = "DAP continue" })

map("n", "<leader>dui", function()
	require("dapui").toggle()
end, { desc = "DAP UI" })

-- TODOs
map("n", "<leader>nt", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "<leader>pt", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- DiffView
map("n", "<leader>dv", "<cmd>:DiffviewOpen<CR>", { desc = "Open DiffView" })
map("n", "<leader>dvc", "<cmd>:DiffviewClose<CR>", { desc = "Close DiffView" })
map("n", "<leader>dvd", "<cmd>:DiffviewOpen dev<CR>", { desc = "Open DiffView against dev" })

-- Floating CMDLine
map("n", "Q", ":Telescope cmdline<CR>", { noremap = true, desc = "Cmdline" })

-- Copilot chat
local chat = require("CopilotChat")
map({ "n" }, "<leader>aa", chat.toggle, { desc = "AI Toggle" })
map({ "v" }, "<leader>aa", chat.open, { desc = "AI Open" })
map({ "n" }, "<leader>ax", chat.reset, { desc = "AI Reset" })
map({ "n" }, "<leader>as", chat.stop, { desc = "AI Stop" })
map({ "n", "v" }, "<leader>ap", chat.select_prompt, { desc = "AI Prompts" })
map({ "n", "v" }, "<leader>aq", function()
	vim.ui.input({
		prompt = "AI Question> ",
	}, function(input)
		if input ~= "" then
			chat.ask(input)
		end
	end)
end, { desc = "AI Question" })
