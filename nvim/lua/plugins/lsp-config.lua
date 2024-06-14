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
				ensure_installed = { "lua_ls", "tsserver", "tailwindcss" },
			})
		end,
	},
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({
                bind = true,
                handler_opts = {
                    border = "single",
                },
            })
        end,
    },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

            local function organize_imports()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) },
                    title = "",
                }
                vim.lsp.buf.execute_command(params)
            end

            local function add_all_imports()
                vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                        only = { "source.addMissingImports.ts" },
                    },
                })
            end
            
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
                capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- format on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
                            desc = "Add all imports, organize imports, and format file",
							group = vim.api.nvim_create_augroup("FixFile", { clear = true }),
							buffer = bufnr,
							callback = function()
                                add_all_imports()
                                organize_imports()
								vim.lsp.buf.format()
							end,
						})
					end
				end,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
				cmd = { "typescript-language-server", "--stdio" },
                commands = {
                    OrganizeImports = {
                        organize_imports,
                        description = "Organize Imports",
                    },
                },
			})

            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
            })

			-- shift k to show hover (doc)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

			-- gr to show all references
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

			-- gi to go to implementation
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})

			-- gd to go to definition
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

            -- <leader>oi to organize imports
            vim.keymap.set("n", "<leader>oi", organize_imports, {})

            -- <leader>ai to add all imports
            vim.keymap.set("n", "<leader>ai", add_all_imports, {})

            -- <leader>gf to format file
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

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
