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
map("n", "<leader>x", '"_d', { silent = true, desc = "Delete keeping clipboard" })
map("v", "<leader>x", '"_d', { silent = true, desc = "Delete keeping clipboard" })

-- Dont die on Q
map("n", "Q", "<nop>")

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

-- LSP (0.12 provides gra=actions, gri=impl, grn=rename, grr=refs, grt=type, gO=symbols, C-s=sig help)
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Goto Definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Goto Implementation" })
map("n", "<leader>fr", vim.lsp.buf.references, { desc = "LSP Find References" })
map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "LSP Workspace Symbol" })
map("n", "<leader>vd", vim.diagnostic.setloclist, { desc = "LSP Show Diagnostics" })
map("n", "<leader>nd", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "<leader>pd", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous Diagnostic" })
