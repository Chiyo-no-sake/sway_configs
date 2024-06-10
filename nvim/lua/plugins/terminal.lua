--- Ctrl+/: Toggle terminal
return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<C-_>]],
            on_open = function()
                vim.cmd("setlocal nospell")
            end,
        })

        -- exit terminal before saving session

        -- keymaps for lazygit
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            hidden = true,
        })

        function _Lazygit_toggle()
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>sg", "<cmd>lua _Lazygit_toggle()<CR>", {
            noremap = true,
            silent = true,
        })

        -- keymaps for lazydocker
        local lazydocker = Terminal:new({
            cmd = "lazydocker",
            direction = "float",
            hidden = true,
        })

        function _Lazydocker_toggle()
            lazydocker:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>sd", "<cmd>lua _Lazydocker_toggle()<CR>", {
            noremap = true,
            silent = true,
        })

        -- keymaps to switch between windows
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end,
}
