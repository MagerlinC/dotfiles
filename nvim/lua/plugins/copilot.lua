return {
  "github/copilot.vim",
  config = function()
    -- Disable Copilot in non-file buffers (pickers, chat UIs, etc.)
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        vim.b.copilot_enabled = vim.bo.buftype == ""
      end,
    })
  end,
}
