local o = vim.o

o.nu = true
o.relativenumber = true
o.clipboard = "unnamed"

o.ignorecase = true
o.smartcase = true

o.scrolloff = 8
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.smartindent = true

o.wrap = false

o.swapfile = false
o.backup = false

o.hlsearch = false
o.incsearch = true

o.termguicolors = true

o.signcolumn = "number"
vim.opt.isfname:append("@-@")

o.updatetime = 50
