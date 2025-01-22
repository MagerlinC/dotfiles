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

o.incsearch = true
o.termguicolors = true

o.signcolumn = "number"
vim.opt.isfname:append("@-@")

o.updatetime = 50
vim.on_key(function(char)
	if vim.fn.mode() == "n" then
		local new_hlsearch =
			vim.tbl_contains({ "<CR>", "n", "N", "z", "zz", "*", "#", "?", "/" }, vim.fn.keytrans(char))
		if vim.opt.hlsearch:get() ~= new_hlsearch then
			vim.opt.hlsearch = new_hlsearch
		end
	end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
