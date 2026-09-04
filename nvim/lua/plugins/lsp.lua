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
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "basedpyright",
                "rust_analyzer",
                "clangd",
                "gopls",
                "ts_ls",
                "jsonls",
                "yamlls",
                "taplo",
                "nil_ls",
            },
            automatic_enable = false,
        },
    },

    {
        "neovim/nvim-lspconfig",

        config = function()
            -- ============================================================
            -- Capabilities
            -- ============================================================

            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- ============================================================
            -- Servers
            -- ============================================================

            local servers = {
                -- ========================================================
                -- Lua
                -- ========================================================

                lua_ls = {
                    capabilities = capabilities,

                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },

                                severity = {
                                    ["undefined-global"] = "Error",
                                    ["undefined-field"] = "Warning",
                                    ["unused-local"] = "Warning",
                                    ["unused-function"] = "Warning",
                                    ["deprecated"] = "Warning",
                                    ["lowercase-global"] = "Error",
                                    ["duplicate-set-field"] = "Error",
                                    ["undefined-env-child"] = "Error",
                                },
                            },

                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file("", true),
                            },

                            completion = {
                                callSnippet = "Replace",
                            },

                            hint = {
                                enable = true,
                            },

                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },

                -- ========================================================
                -- Python
                -- ========================================================

                basedpyright = {
                    capabilities = capabilities,

                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "strict",
                                diagnosticMode = "workspace",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                autoImportCompletions = true,

                                diagnosticSeverityOverrides = {
                                    reportAny = "error",
                                    reportArgumentType = "error",
                                    reportAssertAlwaysTrue = "error",
                                    reportAssignmentType = "error",
                                    reportAttributeAccessIssue = "error",
                                    reportCallIssue = "error",
                                    reportConstantRedefinition = "error",
                                    reportDeprecated = "warning",
                                    reportDuplicateImport = "error",
                                    reportFunctionMemberAccess = "error",
                                    reportGeneralTypeIssues = "error",
                                    reportIncompatibleMethodOverride = "error",
                                    reportIncompatibleVariableOverride = "error",
                                    reportIndexIssue = "error",
                                    reportInvalidStringEscapeSequence = "error",
                                    reportInvalidTypeForm = "error",
                                    reportMissingImports = "error",
                                    reportMissingModuleSource = "error",
                                    reportMissingParameterType = "error",
                                    reportMissingTypeArgument = "error",
                                    reportOptionalCall = "error",
                                    reportOptionalContextManager = "error",
                                    reportOptionalIterable = "error",
                                    reportOptionalMemberAccess = "error",
                                    reportOptionalOperand = "error",
                                    reportOptionalSubscript = "error",
                                    reportOverlappingOverload = "error",
                                    reportPrivateImportUsage = "error",
                                    reportPrivateUsage = "error",
                                    reportRedeclaration = "error",
                                    reportReturnType = "error",
                                    reportSelfClsParameterName = "error",
                                    reportShadowedImports = "error",
                                    reportTypeCommentUsage = "error",
                                    reportUnknownArgumentType = "error",
                                    reportUnknownLambdaType = "error",
                                    reportUnknownMemberType = "error",
                                    reportUnknownParameterType = "error",
                                    reportUnknownVariableType = "error",
                                    reportUnnecessaryCast = "warning",
                                    reportUnnecessaryComparison = "warning",
                                    reportUnnecessaryContains = "warning",
                                    reportUnsupportedDunderAll = "error",
                                    reportUntypedBaseClass = "error",
                                    reportUntypedClassDecorator = "error",
                                    reportUntypedFunctionDecorator = "error",
                                    reportUntypedNamedTuple = "error",
                                    reportUnusedClass = "error",
                                    reportUnusedFunction = "error",
                                    reportUnusedImport = "error",
                                    reportUnusedVariable = "error",
                                },
                            },
                        },
                    },
                },

                -- ========================================================
                -- Rust
                -- ========================================================

                rust_analyzer = {
                    capabilities = capabilities,

                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,

                                buildScripts = {
                                    enable = true,
                                },
                            },

                            check = {
                                command = "clippy",

                                extraArgs = {
                                    "--",
                                    "-W",
                                    "clippy::all",
                                    "-W",
                                    "clippy::pedantic",
                                    "-W",
                                    "clippy::nursery",
                                    "-W",
                                    "clippy::cargo",
                                },
                            },

                            diagnostics = {
                                enable = true,
                            },

                            imports = {
                                granularity = {
                                    group = "module",
                                },

                                prefix = "self",
                            },

                            inlayHints = {
                                bindingModeHints = {
                                    enable = true,
                                },

                                chainingHints = {
                                    enable = true,
                                },

                                closingBraceHints = {
                                    enable = true,
                                },

                                closureReturnTypeHints = {
                                    enable = "always",
                                },

                                discriminantHints = {
                                    enable = true,
                                },

                                expressionAdjustmentHints = {
                                    enable = "always",
                                },

                                lifetimeElisionHints = {
                                    enable = "always",
                                    useParameterNames = true,
                                },

                                parameterHints = {
                                    enable = true,
                                },

                                typeHints = {
                                    enable = true,
                                    hideClosureInitialization = false,
                                    hideNamedConstructor = false,
                                },
                            },
                        },
                    },
                },

                -- ========================================================
                -- C / C++
                -- ========================================================

                clangd = {
                    capabilities = capabilities,

                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--header-insertion-decorators",
                    },

                    init_options = {
                        clangdFileStatus = true,
                    },
                },

                -- ========================================================
                -- Go
                -- ========================================================

                gopls = {
                    capabilities = capabilities,

                    settings = {
                        gopls = {
                            gofumpt = true,
                            staticcheck = true,

                            analyses = {
                                unusedparams = true,
                                unusedwrite = true,
                                shadow = true,
                                nilness = true,
                                unusedvariable = true,
                                fieldalignment = true,
                                nilerr = true,
                            },

                            usePlaceholders = true,
                            completeUnimported = true,
                            deepCompletion = true,
                        },
                    },
                },

                -- ========================================================
                -- TypeScript / JavaScript
                -- ========================================================

                ts_ls = {
                    capabilities = capabilities,

                    settings = {
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },

                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },

                -- ========================================================
                -- JSON
                -- ========================================================

                jsonls = {
                    capabilities = capabilities,

                    settings = {
                        json = {
                            validate = {
                                enable = true,
                            },

                            format = {
                                enable = true,
                            },
                        },
                    },
                },

                -- ========================================================
                -- YAML
                -- ========================================================

                yamlls = {
                    capabilities = capabilities,

                    settings = {
                        yaml = {
                            validate = true,

                            format = {
                                enable = true,
                            },

                            hover = true,
                            completion = true,
                        },
                    },
                },

                -- ========================================================
                -- TOML
                -- ========================================================

                taplo = {
                    capabilities = capabilities,
                },

                -- ========================================================
                -- Nix
                -- ========================================================

                nil_ls = {
                    capabilities = capabilities,

                    settings = {
                        ["nil"] = {
                            formatting = {
                                command = {
                                    "nixfmt",
                                },
                            },

                            diagnostics = {
                                ignored = {},
                            },
                        },
                    },
                },
            }

            -- ============================================================
            -- Register servers using Neovim 0.11+ API
            -- ============================================================

            for server, config in pairs(servers) do
                vim.lsp.config(server, config)
            end

            vim.lsp.enable(vim.tbl_keys(servers))
        end,
    },
}
