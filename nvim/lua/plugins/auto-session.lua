return {}
-- return {
-- 	"rmagatti/auto-session",
--     dependencies = {
--         "nvim-neo-tree/neo-tree.nvim",
--     },
--     disable = true,
-- 	config = function()
-- 		require("auto-session").setup({
-- 			log_level = "error",
-- 			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
--             post_restore_cmds = {
--                 "Neotree"
--             },
--             pre_save_cmds = {
--                 "tabdo Neotree close",
--             },
-- 		})
-- 	end,
-- }
