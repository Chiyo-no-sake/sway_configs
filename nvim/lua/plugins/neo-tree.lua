return {
	"nvim-neo-tree/neo-tree.nvim",
    lazy = false,
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
	end,
	init = function()
		if vim.fn.argc(-1) == 1 then
			local stat = vim.loop.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				require("neo-tree").setup({
					filesystem = {
						hijack_netrw_behavior = "open_current",
                        -- must be set to not conflict with neotree
						auto_clean_after_session_restore = true,
					},
				})
			end
		end
	end,
}
