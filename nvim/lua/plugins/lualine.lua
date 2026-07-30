return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "echasnovski/mini.icons",
        "rmagatti/auto-session",
    },
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                section_separators = { left = " ⟩ ", right = " ⟨ " },
                component_separators = { left = " ⟩ ", right = " ⟨ " },
            },
            extensions = { "mason", "lazy" },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str) return str:sub(1, 1) end,
                    },
                },
                lualine_b = {
                    {
                        "location",
                        color = { fg = "#eba0ac" },
                    },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_lsp" },
                        sections = { "error", "warn", "info", "hint" },
                        colored = true,
                        update_in_insert = true,
                        always_visible = true,
                    },
                    {
                        "branch",
                        color = { fg = "#cba6f7" },
                    },
                    {
                        "diff",
                        colored = true,
                        symbols = { added = "󱇬 ", modified = "󱣳 ", removed = "󱘹 " },
                    },
                    {
                        function()
                            return require("lsp-progress").progress()
                        end,
                        color = { fg = "#89b4fa" },
                    },
                    {
                        function()
                            return require("action-hints").statusline()
                        end,
                        color = { fg = "#f6b596" },
                    },
                },
                lualine_x = {
                    { function() return require("auto-session.lib").current_session_name() end },
                },
                lualine_y = {
                    {
                        "encoding",
                        color = { fg = "#a6e3a1" },
                    },
                },
                lualine_z = {
                    {
                        "datetime",
                        style = "default",
                    },
                },
            },
            tabline = {
                lualine_a = {
                    {
                        "buffers",
                        show_filename_only = true,
                        hide_filename_extension = false,
                        show_modified_status = true,
                        mode = 0,
                        symbols = {
                            modified = " 󰷫",
                            alternate_file = "󰷈 ",
                            directory = " ",
                        },
                    },
                },
            },
        })

        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end,
}
