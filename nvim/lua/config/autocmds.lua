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

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)

        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
