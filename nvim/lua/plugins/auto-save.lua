return {
	"Pocco81/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			-- your config goes here
			-- or just leave it empty :)

			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")

				if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
					if
						fn.getbufvar(buf, "&buftype") == "terminal"
						or fn.getbufvar(buf, "&buftype") == "quickfix"
						or fn.getbufvar(buf, "&filetype") == "harpoon"
						or fn.getbufvar(buf, "&filetype") == "telescope"
					then
						return false
					end
					return true -- met condition(s), can save
				end

				return false -- can't save
			end,

			vim.api.nvim_set_keymap("n", "<leader>tas", ":ASToggle<CR>", { noremap = true, silent = true }),
		})
	end,
}
