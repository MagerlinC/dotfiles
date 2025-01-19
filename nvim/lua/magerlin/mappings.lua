local map = vim.keymap.set
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- source keymaps
map("n", "<leader>cc", ":source ~/.config/nvim/lua/mappings.lua<CR>", { desc = "source keymaps" })

-- General mapping
map("n", "gb", "<C-o>", { silent = true, desc = "Go back" })

-- Visual mode move lines
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected lines up" })

-- Keep cursor in middle while going up/down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "N", "Nzzzv", { silent = true, desc = "Move to prev search item" })
map("n", "n", "nzzzv", { silent = true, desc = "Move to next search item" })
-- Clipboard saving paste/delet
map("x", "<leader>p", '"_dP', { silent = true, desc = "Paste over keeping clipboard" })
map("n", "<leader>d", '"_d', { silent = true, desc = "Delete keeping clipboard" })
map("v", "<leader>d", '"_d', { silent = true, desc = "Delete keeping clipboard" })
-- Dont die on Q
map("n", "Q", "<nop>")

-- Git
map("n", "<leader>gb", ":GitBlameToggle<CR>", { silent = true, desc = "Git blame" })

-- Hop
local hop = require("hop")
local directions = require("hop.hint").HintDirection
map("", "<leader>hw", function()
	hop.hint_words()
end, { desc = "Hop word" })
map("", "f", function()
	hop.hint_char1({ direction = directions.after_cursor, current_line_only = true })
end, { remap = true })
map("", "f", function()
	hop.hint_char1({ direction = directions.before_cursor, current_line_only = true })
end, { remap = true })
map("", "t", function()
	hop.hint_char1({ direction = directions.after_cursor, current_line_only = true, hint_offset = -1 })
end, { remap = true })
map("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- Navigate buffers
map("n", "<leader>bd", ":bd<CR>", { desc = "close current buffer" })

map("n", "<leader>bo", ":%bd|e#<CR>", { silent = true, desc = "Close all buffers except current" })

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>sb", builtin.git_branches, { desc = "Telescope git branches" })
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

-- NvimTree
-- map("n", "<leader>+", ":NvimTreeResize +10<CR>", { silent = true, desc = "Expand NvimTree width" })
-- map("n", "<leader>-", ":NvimTreeResize -10<CR>", { silent = true, desc = "Reduce NvimTree width" })

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
map("n", "<leader>gs", ":G<CR>", { desc = "Git status" })
map("n", "<leader>ga", ":G add . <CR>", { desc = "Git add all" })
map("n", "<leader>gc", ":G commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", ":G push<CR>", { desc = "Git push" })

-- Barbar
map("n", "<leader>bp", ":BufferPick<CR>", { desc = "Buffer 1" })

map("n", "L", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "H", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
