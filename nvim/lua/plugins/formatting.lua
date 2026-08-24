return {
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
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
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

            formatters = {
                shfmt = {
                    prepend_args = {
                        "-i",
                        "4",
                        "-ci",
                        "-sr",
                    },
                },

                prettier = {
                    prepend_args = {
                        "--single-quote",
                        "--trailing-comma",
                        "all",
                    },
                },
            },
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
                desc = "Format buffer",
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
                python = {
                    "ruff",
                },

                javascript = {
                    "eslint_d",
                },

                javascriptreact = {
                    "eslint_d",
                },

                typescript = {
                    "eslint_d",
                },

                typescriptreact = {
                    "eslint_d",
                },

                sh = {
                    "shellcheck",
                },

                bash = {
                    "shellcheck",
                },

                yaml = {
                    "yamllint",
                },

                markdown = {
                    "markdownlint",
                },
            }

            local group = vim.api.nvim_create_augroup("UserLint", { clear = true })

            vim.api.nvim_create_autocmd({
                "BufEnter",
                "BufWritePost",
                "InsertLeave",
            }, {
                group = group,

                callback = function()
                    lint.try_lint()
                end,
            })
        end,

        keys = {
            {
                "<leader>l",
                function()
                    require("lint").try_lint()
                end,
                desc = "Lint buffer",
            },
        },
    },
}
