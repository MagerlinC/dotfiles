return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "js-debug-adapter")
				table.insert(opts.ensure_installed, "netcoredbg")
			end,
		},
	},
	config = function() end,
	opts = function()
		local dap = require("dap")
		if not dap.adapters["pwa-node"] then
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}
		end
		if not dap.adapters["node"] then
			dap.adapters["node"] = function(cb, config)
				if config.type == "node" then
					config.type = "pwa-node"
				end
				local nativeAdapter = dap.adapters["pwa-node"]
				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end

		-- Debugging C# with netcoredbg
		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		}

		local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

		local vscode = require("dap.ext.vscode")
		vscode.type_to_filetypes["node"] = js_filetypes
		vscode.type_to_filetypes["pwa-node"] = js_filetypes

		for _, language in ipairs(js_filetypes) do
			if not dap.configurations[language] then
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						name = "Next.js: debug server-side",
						type = "pwa-node",
						request = "attach",
						port = 9230,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						cwd = "${workspaceFolder}",
					},
				}
			end
		end
	end,
}
