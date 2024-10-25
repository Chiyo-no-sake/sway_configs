if vim.g.vscode then
	local vscode = require("vscode")

	-- <leader>zz to save and quit
	vim.keymap.set("n", "<leader>zz", ":wa<CR>:qa<CR>", { noremap = true })

	-- vscode keymaps
	vim.keymap.set("n", "<leader>ca", function()
		vscode.action("editor.action.codeAction")
	end)

	-- format
	vim.keymap.set("n", "<leader>gf", function()
		vscode.action("editor.action.formatDocument")
	end)

	-- go to next diagnostic
	vim.keymap.set("n", "<leader>]e", function()
		vscode.action("editor.action.marker.next")
	end)

	-- go to previous diagnostic
	vim.keymap.set("n", "<leader>[e", function()
		vscode.action("editor.action.marker.prev")
	end)

	-- debug toggle breakpoint
	vim.keymap.set("n", "<leader>db", function()
		vscode.action("editor.debug.action.toggleBreakpoint")
	end)

	-- debug toggle inline breakpoint
	vim.keymap.set("n", "<leader>dbi", function()
		vscode.action("editor.debug.action.toggleInlineBreakpoint")
	end)

	-- debug start
	vim.keymap.set("n", "<leader>ds", function()
		vscode.action("workbench.action.debug.start")
	end)

	-- debug continue
	vim.keymap.set("n", "<leader>dc", function()
		vscode.action("workbench.action.debug.continue")
	end)

	-- debug step over
	vim.keymap.set("n", "<leader>do", function()
		vscode.action("workbench.action.debug.stepOver")
	end)

	-- debug step into
	vim.keymap.set("n", "<leader>di", function()
		vscode.action("workbench.action.debug.stepInto")
	end)

	-- debug stop
	vim.keymap.set("n", "<leader>dq", function()
		vscode.action("workbench.action.debug.stop")
	end)
end
