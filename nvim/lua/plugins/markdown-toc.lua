return {
  "hedyhli/markdown-toc.nvim",
  ft = "markdown",  -- Lazy load on markdown filetype
  cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
  opts = {
    item_formatter = function(item, _)
      local name, explicit_id = item.name:match("^(.-)%s*{#([^}]+)}%s*$")
      if not name then
        name = item.name
      end
      local link = explicit_id or name:lower()
          :gsub("[^%w%s%-]", "")
          :gsub("%s+", "-")
      local indent = string.rep("  ", item.level - 1)
      return ("%s* [%s](#%s)"):format(indent, name, link)
    end,
  },

}
