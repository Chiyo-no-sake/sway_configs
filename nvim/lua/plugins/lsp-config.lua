return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.solidity.setup({
				capabilities = capabilities,
				cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
				filetypes = { "solidity" },
				single_file_support = true,
			})

			lspconfig.tsserver.setup({
				on_attach = function(client, bufnr)
					-- format on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("Format", { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
				cmd = { "typescript-language-server", "--stdio" },
			})

			-- shift k to show hover (doc)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- gr to show all references
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

			-- gi to go to implementation
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})

			-- gd to go to definition
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

			-- <leader>ca to show code actions
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- <leader>e to show under-cursor diagnostic in a floating window
			vim.api.nvim_set_keymap(
				"n",
				"<leader>e",
				':lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})<CR>',
				{}
			)

			-- <leader>ne to jump to next diagnostic
			vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next, {})

			-- <leader>pe to jump to previous diagnostic
			vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev, {})

			-- <leader>rn to rename
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
		end,
	},
}
