vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")


-- required settings for vimwiki
vim.cmd("set nocompatible")
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.cc = "80"
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.gdefault = true
vim.opt.spell = true
vim.o.exrc = true
vim.opt.splitright = true

vim.cmd("set nosmd")
vim.cmd("set noru")

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- TODO: not working, need to investigate
-- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
-- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
-- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
-- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

vim.keymap.set({ "n", "t" }, "<leader>zz", "vim.cmd('wa') | vim.cmd('qa')", { noremap = true })

-- Set the sessionoptions
-- required for debugging with DAP
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Set the colorscheme
