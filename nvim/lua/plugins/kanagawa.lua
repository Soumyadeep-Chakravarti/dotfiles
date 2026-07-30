return {
    "rebelot/kanagawa.nvim",
    branch = "master",
    config = function()
        require("kanagawa").setup({
            compile = true,
            undercurl = true,
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true,
            overrides = function(colors)
                return {
                    ["@markup.link.url.markdown_inline"] = { link = "Special" },
                    ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
                    ["@markup.italic.markdown_inline"] = { link = "Exception" },
                    ["@markup.raw.markdown_inline"] = { link = "String" },
                    ["@markup.list.markdown"] = { link = "Function" },
                    ["@markup.quote.markdown"] = { link = "Error" },
                    ["@markup.list.checked.markdown"] = { link = "WarningMsg" },
                }
            end,
            dimInactive = false,
            terminalColors = true,
            colors = {
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            theme = "wave",
            background = {
                dark = "wave",
                light = "lotus",
            },
        })
        vim.cmd("colorscheme kanagawa")
    end,
}
