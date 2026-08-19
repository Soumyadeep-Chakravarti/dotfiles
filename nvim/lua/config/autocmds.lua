local group = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "help", "man", "qf" },
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Automatically show diagnostics when the cursor rests on them.
vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = function()
        vim.diagnostic.open_float(nil, {
            focus = false,
            scope = "cursor",
            border = "rounded",
            source = "if_many",
        })
    end,
})
