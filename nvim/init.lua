vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "Snacks" }, -- Recognize 'vim' as a global variable
      },
    },
  },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
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

require("vim._core.ui2").enable()

require("magerlin.mappings")
require("magerlin.options")

-- Native LSP completion (replaces blink.cmp)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.cmd("hi IlluminatedWordText guibg=none gui=underline")
vim.cmd("hi IlluminatedWordRead guibg=none gui=underline")
vim.cmd("hi IlluminatedWordWrite guibg=none gui=underline")

require("nvim-highlight-colors").setup({
  enable_named_colors = false,
})

require("nvim-ts-autotag").setup({
  opts = {
    -- Defaults
    enable_close = true,           -- Auto close tags
    enable_rename = true,          -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
})

-- -- Copilot chat
-- local chat = require("CopilotChat")
-- local select = require("CopilotChat.select")
-- chat.setup({
--   model = "gpt-4.1",
--   references_display = "write",
--   debug = false,
--   question_header = "Mikkel",
--   selection = select.visual,
--   context = "buffers",
--   mappings = {
--     reset = false,
--     show_diff = {
--       full_diff = true,
--     },
--   },
-- })

-- Remove unused imports on save via vtsls code action
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  group = vim.api.nvim_create_augroup("TsRemoveUnusedImports", {}),
  callback = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
    })
  end,
})
