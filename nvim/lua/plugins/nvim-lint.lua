return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")

    -- Run through npx so versions match scripts/lint.sh
    local function via_npx(linter, npx_args)
      linter.cmd = "npx"
      for i = #npx_args, 1, -1 do
        table.insert(linter.args, 1, npx_args[i])
      end
    end
    via_npx(lint.linters["markdownlint-cli2"], { "-y", "markdownlint-cli2@0.23.3" })
    local cspell = lint.linters.cspell
    via_npx(cspell, {
      "-y", "-p", "cspell@10.3.5", "-p", "@cspell/dict-da-dk@4.1.2", "cspell",
    })
    table.insert(cspell.args, "--locale")
    table.insert(cspell.args, "en,da-DK")

    lint.linters_by_ft = { markdown = { "markdownlint-cli2", "cspell" } }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      callback = function() lint.try_lint() end,
    })
  end,
}
