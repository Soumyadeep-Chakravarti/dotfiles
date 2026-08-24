return {
    {
        "williamboman/mason.nvim",

        opts = {
            ui = {
                border = "rounded",
            },
        },
    },

    {
        "stevearc/conform.nvim",

        event = { "BufWritePre" },

        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                rust = { "rustfmt" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                go = { "gofumpt" },

                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },

                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                toml = { "taplo" },

                sh = { "shfmt" },
                bash = { "shfmt" },
                nix = { "nixfmt" },
            },

            format_on_save = {
                timeout_ms = 3000,
                lsp_format = "fallback",
            },

            notify_on_error = true,
        },

        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({
                        async = true,
                        lsp_format = "fallback",
                    })
                end,
                mode = { "n", "v" },
                desc = "Format",
            },
        },
    },

    {
        "mfussenegger/nvim-lint",

        event = {
            "BufReadPre",
            "BufNewFile",
        },

        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                lua = {},
                python = { "ruff" },
                rust = { "clippy" },
                c = { "clangtidy" },
                cpp = { "clangtidy" },
                go = { "golangcilint" },

                javascript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescript = { "eslint_d" },
                typescriptreact = { "eslint_d" },

                json = { "jsonlint" },
                yaml = { "yamllint" },
                markdown = { "markdownlint" },
                toml = { "taplo" },
                sh = { "shellcheck" },
                bash = { "shellcheck" },
            }

            local group = vim.api.nvim_create_augroup("UserLint", {})

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = group,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end, { desc = "Lint current file" })
        end,
    },
}
