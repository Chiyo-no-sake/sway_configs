return {
	"nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
            refactor = {
                highlight_definitions = { enable = true, clear_on_cursor_move = true },
                smart_rename = {
                    enable = true,
                    keymaps = {
                        smart_rename = "<leader>rn",
                    },
                },
                navigation = {
                    enable = true,
                    keymaps = {
                        goto_definition_lsp_fallback = "gd",
                    }
                }
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["<leader>ib"] = {
                            query = "@conditional.outer",
                            description = "Select current block (inner)",
                        },
                        ["<leader>sob"] = {
                            query = "@conditional.outer",
                            description = "Select current block (outer)",
                        },
                        ["<leader>sof"] = {
                            query = "@function.outer",
                            description = "Select function (outer)",
                        },
                        ["<leader>sif"] = {
                            query = "@function.inner",
                            description = "Select function (inner)",
                        },
                        ["<leader>soc"] = {
                            query = "@class.outer",
                            description = "Select class (outer)",
                        },
                        ["<leader>sic"] = {
                            query = "@class.inner",
                            description = "Select class (inner)",
                        },
                    },
                    selection_modes = {
                        ["@function.outer"] = "V",
                        ["@function.inner"] = "V",
                        ["@class.outer"] = "V",
                        ["@class.inner"] = "V",
                    }
                }
            }
		})
	end,
}
