local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui" },
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			},
		},
		{
			"microsoft/vscode-js-debug",
			-- Run cd ~/.local/share/nvim/lazy/vscode-js-debug && rm -rf package-lock.json if this fails
			build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv -f dist out",
		},
	},
	keys = {
		-- Snippet
	},
}

M.config = function()
	local dap = require("dap")
	local dapui = require("dapui")
	local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

	dap.adapters.coreclr = {
		type = "executable",
		command = "~/netcoredbg/netcoredbg",
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
	-- setup dap config by VsCode launch.json file
	local dap_vscode = require("dap.ext.vscode")
	local json = require("plenary.json")
	---@diagnostic disable-next-line: duplicate-set-field
	dap_vscode.json_decode = function(str)
		return vim.json.decode(json.json_strip_comments(str, {}))
	end

	dap_vscode.type_to_filetypes["node"] = js_filetypes

	if not dap.adapters["pwa-node"] then
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
					"${port}",
				},
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

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
	-- language config
	for _, language in ipairs(js_filetypes) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to process",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-msedge",
				request = "attach",
				name = "Attach to Edge",
				port = 9222,
				webRoot = "${workspaceFolder}",
			},
			{
				type = "pwa-msedge",
				request = "launch",
				name = 'Start Edge with "localhost"',
				url = "http://localhost:3000",
				webRoot = vim.fn.getcwd(),
				protocol = "inspector",
				sourceMaps = true,
				userDataDir = false,
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
				},

				-- From https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/plugins/dap.lua
				-- To test how it behaves
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
				sourceMapPathOverrides = {
					["./*"] = "${workspaceFolder}/src/*",
				},
			},
		}
	end
end

return M
