return {
  "andrewferrier/wrapping.nvim",
  ft = { "markdown", "tex", "text", "rst", "asciidoc" },
  config = function()
    require("wrapping").setup()
  end
}
