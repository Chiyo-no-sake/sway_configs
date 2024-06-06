vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.g.mapleader = " "

-- TODO: not working, need to investigate
-- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
-- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
-- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
-- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])


-- Set the sessionoptions
-- required for debugging with DAP

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
