return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			-- vim way: ; goes to the direction you were moving.
			-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			lsp_interop = { enable = true },
			refactor = {
				highlight_definitions = { enable = true, clear_on_cursor_move = true },
--				smart_rename = {
--					enable = true,
--					keymaps = {
--						smart_rename = "<leader>rn",
--					},
--				},
--				navigation = {
--					enable = true,
--					keymaps = {
--						goto_definition_lsp_fallback = "gd",
--					},
--				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",
						["im"] = "@function.inner",
						["am"] = "@function.outer",
						["ic"] = "@class.inner",
						["ac"] = "@class.outer",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["<leader>nm"] = "@function.outer",
						["<leader>nc"] = "@class.outer",
					},
					goto_next_end = {
						["<leader>nM"] = "@function.outer",
						["<leader>nC"] = "@class.outer",
					},
					goto_previous_start = {
						["<leader>pm"] = "@function.outer",
						["<leader>pc"] = "@class.outer",
					},
					goto_previous_end = {
						["<leader>pM"] = "@function.outer",
						["<leader>pC"] = "@class.outer",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
