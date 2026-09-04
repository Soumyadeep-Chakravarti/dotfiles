vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- General
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Window resizing
map("n", "<leader>+", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<leader>-", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<leader>>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })
map("n", "<leader><", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })

-- Indentation
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Editing
map("n", "<A-j>", "<cmd>move .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>move .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":move '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":move '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Clipboard
map("n", "<leader>yp", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Yank file path" })
map("n", "<leader>yd", function()
    vim.fn.setreg("+", vim.fn.expand("%:p:h"))
end, { desc = "Yank file directory" })
