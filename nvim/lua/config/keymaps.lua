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

-- Diagnostics
map("n", "]d", vim.diagnostic.goto_next, {
    desc = "Next diagnostic",
})

map("n", "[d", vim.diagnostic.goto_prev, {
    desc = "Previous diagnostic",
})

map("n", "<leader>e", function()
    vim.diagnostic.open_float(nil, {
        focus = true,
        scope = "cursor",
        border = "rounded",
        source = "if_many",
    })
end, {
    desc = "Show diagnostic",
})

map("n", "<leader>q", vim.diagnostic.setloclist, {
    desc = "Diagnostics list",
})

-- LSP
map("n", "K", vim.lsp.buf.hover, {
    desc = "Hover documentation",
})

map("n", "<leader>rn", vim.lsp.buf.rename, {
    desc = "Rename symbol",
})

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code action",
})

map("n", "gd", vim.lsp.buf.definition, {
    desc = "Go to definition",
})

map("n", "gD", vim.lsp.buf.declaration, {
    desc = "Go to declaration",
})

map("n", "gr", vim.lsp.buf.references, {
    desc = "Find references",
})

map("n", "gi", vim.lsp.buf.implementation, {
    desc = "Go to implementation",
})

map("n", "<leader>ds", vim.lsp.buf.document_symbol, {
    desc = "Document symbols",
})

map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, {
    desc = "Workspace symbols",
})
