return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- priority = 1000,
		config = function()
			require("catppuccin").setup({
				default_integration = true,
			})
		end,
		enabled = false,
	},
	{
		"navarasu/onedark.nvim",
		priority = 10000,
		config = function()
			local onedark = require("onedark")
			onedark.setup({
				style = "warmer",
			})

			onedark.load()
			vim.cmd("colorscheme onedark")
		end,
	},
	{
		"oncomouse/lushwal.nvim",
		cmd = { "LushwalCompile" },
		dependencies = {
			{ "rktjmp/lush.nvim" },
			{ "rktjmp/shipwright.nvim" },
		},
	},
}
