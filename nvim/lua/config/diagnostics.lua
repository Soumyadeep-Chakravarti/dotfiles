vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        source = "if_many",
    },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
        },
    },

    underline = true,

    update_in_insert = false,

    severity_sort = true,

    float = {
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
        focusable = false,
        scope = "cursor",
    },
})

local group = vim.api.nvim_create_augroup("UserDiagnostics", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    callback = function()
        vim.diagnostic.open_float(nil)
    end,
})
