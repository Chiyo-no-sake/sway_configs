return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,

				-- js
				--require("none-ls.diagnostics.eslint_d"),
				-- null_ls.builtins.formatting.prettier.with({
				--                 extra_filetypes = {"solidity"},
				--             }),

				-- python
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,
			},
		})

		-- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
