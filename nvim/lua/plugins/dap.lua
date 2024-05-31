--[[
-- This module configures the nvim-dap plugin and its dependencies.
--
-- This also configures the js-debug-adapter to be used with the pwa-node adapter.
-- Maybe it should be moved to a separate module #TODO 🤔, but for now it's here.
--
--
--]]

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "js-debug-adapter")
			end,
		},
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"Joakker/lua-json5",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		--		dap.listeners.before.event_terminated.dapui_config = function()
		--			dapui.close()
		--		end
		--
		--		dap.listeners.before.event_exited.dapui_config = function()
		--			dapui.close()
		--		end

		vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

		-- vvvvvvvvvvv -- JAVASCRIPT & TYPESCRIPT DEBUGGER CONFIGURATION -- vvvvvvvvvvv --

		local jsDebugServerPath = require("mason-registry").get_package("js-debug-adapter"):get_install_path()
			.. "/js-debug/src/dapDebugServer.js"

		if not dap.adapters["pwa-node"] then
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { jsDebugServerPath, "${port}" },
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

		local pwa_langs = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
		for _, language in ipairs(pwa_langs) do
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
					request = "launch",
					name = "npm start",
					runtimeExecutable = "npm",
					runtimeArgs = { "run", "start" },
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end

		-- ^^^^^^^^^ -- JAVASCRIPT & TYPESCRIPT DEBUGGER CONFIGURATION -- ^^^^^^^^^ --

		-- vvvvvvvvvvv -- launch.json support -- vvvvvvvvvvv --
		require("dap.ext.vscode").load_launchjs(
			nil,
			-- this table maps "type" in the configuration to the extensions that should use them
			{
				["pwa-node"] = {
					"ts",
					"js",
					"tsx",
					"jsx",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
				},
			}
		)

		-- ^^^^^^^^^ -- launch.json support -- ^^^^^^^^^ --

		vim.keymap.set("n", "<Leader>dq", function()
			dapui.close()
			dap.terminate()
		end, {})

		vim.keymap.set("n", "<Leader>dc", dap.continue, {})
		vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})

		vim.keymap.set("n", "<F5>", dap.continue, {})
		vim.keymap.set("n", "<F8>", dap.step_over, {})
		vim.keymap.set("n", "<F7>", dap.step_into, {})
		vim.keymap.set("n", "<F9>", dap.step_out, {})
	end,
}
