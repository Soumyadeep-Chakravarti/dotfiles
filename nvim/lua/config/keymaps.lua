local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Oil
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

-- Diagnostics
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

-- Format
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "Format current file" })

-- Projects
vim.keymap.set("n", "<leader>fp", "<cmd>FzfProjects<CR>", { noremap = true, silent = true, desc = "Find Recent Projects" })

-- Center scroll toggle
keymap.set('n', '<leader>to', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end, opts)

-- Spell check
keymap.set('n', '<leader>sc', ':setlocal spell spelllang=en_us<CR>', opts)

-- Clear search
keymap.set("n", "<C-c>", ":nohl<CR>", opts)

-- Pane navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Window management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)
keymap.set("n", "<leader>sh", ":split<CR>", opts)

-- Buffer management
keymap.set("n", "<leader>n", ":bn<CR>", opts)
keymap.set("n", "<leader>p", ":bp<CR>", opts)
keymap.set("n", "<leader>d", ":bd<CR>", opts)
keymap.set("n", "<leader>o", ":enew<CR>", opts)

-- Code folding
keymap.set("n", "<leader>fi", ":set foldmethod=indent<CR>", opts)

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Line numbers
keymap.set("n", "<leader>hn", ":set norelativenumber nonumber<CR>", opts)
keymap.set("n", "<leader>sn", ":set number relativenumber<CR>", opts)

-- VimTex
keymap.set("n", "<leader>lc", ":VimtexClean<CR>", { noremap = true })
