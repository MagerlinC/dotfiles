local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Horizontal scrolling
map("n", "zh", "40zh", { desc = "scroll left" })
map("n", "zl", "40zl", { desc = "scroll right" })

-- Splitting
map("n", "<leader>-", ":split<CR>", { desc = "split horizontal" })
map("n", "<leader>|", ":vsplit<CR>", { desc = "split vertical" })

-- Navigational mapping
map("n", "gb", "<C-o>", { silent = true, desc = "Go back" })

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

-- Closing buffers
map("n", "<leader>bd", ":bd<CR>", { desc = "close current buffer" })
CloseAllButCurrentBuffer = function()
	local current_buf = vim.fn.bufnr()
	local current_win = vim.fn.win_getid()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	for _, buf in ipairs(bufs) do
		if buf.bufnr ~= current_buf then
			vim.cmd("silent! bdelete " .. buf.bufnr)
		end
	end
	vim.fn.win_gotoid(current_win)
end

map("n", "<leader>bo", CloseAllButCurrentBuffer, { silent = true, desc = "Close all buffers except current" })

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

-- Nvim DAP
map("n", "<leader>db", "<cmd>:DapToggleBreakpoint<CR>", { desc = "DAP toggle breakpoint" })
map("n", "<leader>dB", "<cmd>:DapToggleClearBreakpoints<CR>", { desc = "DAP clear breakpoints" })
map("n", "<leader>ds", "<cmd>:DapStepOver<CR>", { desc = "DAP Step Over" })
map("n", "<leader>dc", "<cmd>:DapContinue<CR>", { desc = "DAP continue" })
map("n", "<leader>di", "<cmd>:DapStepInto<CR>", { desc = "DAP Step Into" })
map("n", "<leader>dt", "<cmd>:DapTerminate<CR>", { desc = "DAP Terminate" })

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
map("n", "<leader>dv", "<cmd>:CodeDiff<CR>", { desc = "Open Diff" })
map("n", "<leader>dvd", "<cmd>:CodeDiff file dev<CR>", { desc = "Open Diff with dev" })

-- -- Copilot chat
-- local chat = require("CopilotChat")
-- map({ "n" }, "<leader>aa", chat.toggle, { desc = "AI Toggle" })
-- map({ "v" }, "<leader>aa", chat.open, { desc = "AI Open" })
-- map({ "n" }, "<leader>ax", chat.reset, { desc = "AI Reset" })
-- map({ "n" }, "<leader>as", chat.stop, { desc = "AI Stop" })
-- map({ "n", "v" }, "<leader>ap", chat.select_prompt, { desc = "AI Prompts" })
-- map({ "n", "v" }, "<leader>aq", function()
--   vim.ui.input({
--     prompt = "AI Question> ",
--   }, function(input)
--     if input ~= "" then
--       chat.ask(input)
--     end
--   end)
-- end, { desc = "AI Question" })
--
-- -- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Goto Definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Goto Implementation" })
--map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "LSP Workspace Symbol" })
map("n", "<leader>vd", vim.diagnostic.setloclist, { desc = "LSP Show Diagnostics" })
map("n", "<leader>nd", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>pd", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { desc = "LSP Code Action" })
map("n", "<leader>fr", vim.lsp.buf.references, { desc = "LSP References" })
map("n", "<leader>cr", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
