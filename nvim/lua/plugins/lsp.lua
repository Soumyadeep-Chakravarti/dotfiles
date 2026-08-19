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
				"pyright",
				"rust_analyzer",
				"clangd",
				"gopls",
				"ts_ls",
				"jsonls",
				"yamlls",
				"taplo",
				"nil_ls",
			},
			automatic_enable = true,
		},
	},

	{
		"neovim/nvim-lspconfig",

		config = function()
			-- ============================================================
			-- Diagnostics
			-- ============================================================

			vim.diagnostic.config({
				virtual_text = {
					spacing = 2,
					source = "if_many",
					prefix = "●",
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
					focusable = true,
					scope = "cursor",
				},

				jump = {
					float = true,
				},
			})

			-- ============================================================
			-- Diagnostic highlight groups
			-- ============================================================

			vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {
				link = "Comment",
			})

			-- ============================================================
			-- Diagnostic autocmds
			-- ============================================================

			local diagnostic_group = vim.api.nvim_create_augroup("UserDiagnostics", { clear = true })

			-- Show diagnostic information when cursor rests on a problem.
			vim.api.nvim_create_autocmd("CursorHold", {
				group = diagnostic_group,
				callback = function()
					local opts = {
						focusable = false,
						close_events = {
							"BufLeave",
							"CursorMoved",
							"InsertEnter",
							"FocusLost",
						},
						border = "rounded",
						source = "if_many",
						prefix = "",
						scope = "cursor",
					}

					vim.diagnostic.open_float(nil, opts)
				end,
			})

			-- ============================================================
			-- LSP Attach
			-- ============================================================

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),

				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if not client then
						return
					end

					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, {
							buffer = bufnr,
							silent = true,
							desc = desc,
						})
					end

					-- ====================================================
					-- Navigation
					-- ====================================================

					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
					map("n", "gr", vim.lsp.buf.references, "Find references")

					-- ====================================================
					-- Information
					-- ====================================================

					map("n", "K", vim.lsp.buf.hover, "Hover documentation")
					map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

					-- ====================================================
					-- Refactoring
					-- ====================================================

					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

					-- ====================================================
					-- Diagnostics
					-- ====================================================

					map("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostics")

					map("n", "[d", function()
						vim.diagnostic.jump({
							count = -1,
							float = true,
						})
					end, "Previous diagnostic")

					map("n", "]d", function()
						vim.diagnostic.jump({
							count = 1,
							float = true,
						})
					end, "Next diagnostic")

					map("n", "[e", function()
						vim.diagnostic.jump({
							count = -1,
							severity = vim.diagnostic.severity.ERROR,
							float = true,
						})
					end, "Previous error")

					map("n", "]e", function()
						vim.diagnostic.jump({
							count = 1,
							severity = vim.diagnostic.severity.ERROR,
							float = true,
						})
					end, "Next error")

					map("n", "[w", function()
						vim.diagnostic.jump({
							count = -1,
							severity = vim.diagnostic.severity.WARN,
							float = true,
						})
					end, "Previous warning")

					map("n", "]w", function()
						vim.diagnostic.jump({
							count = 1,
							severity = vim.diagnostic.severity.WARN,
							float = true,
						})
					end, "Next warning")

					map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics location list")

					map("n", "<leader>xx", vim.diagnostic.setqflist, "Diagnostics quickfix list")

					-- ====================================================
					-- Symbols
					-- ====================================================

					map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")

					map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")

					-- ====================================================
					-- LSP management
					-- ====================================================

					map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP info")

					map("n", "<leader>lr", "<cmd>LspRestart<cr>", "Restart LSP")

					-- ====================================================
					-- Inlay hints
					-- ====================================================

					if client:supports_method("textDocument/inlayHint") then
						map("n", "<leader>uh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
								bufnr = bufnr,
							}), { bufnr = bufnr })
						end, "Toggle inlay hints")
					end

					-- ====================================================
					-- Code lens
					-- ====================================================

					if client:supports_method("textDocument/codeLens") then
						map("n", "<leader>cl", vim.lsp.codelens.run, "Run code lens")

						vim.api.nvim_create_autocmd({
							"BufEnter",
							"BufWritePost",
							"CursorHold",
						}, {
							buffer = bufnr,
							callback = vim.lsp.codelens.refresh,
						})
					end

					-- ====================================================
					-- Document highlighting
					-- ====================================================

					if client:supports_method("textDocument/documentHighlight") then
						local highlight_group =
							vim.api.nvim_create_augroup("UserLspDocumentHighlight", { clear = false })

						vim.api.nvim_create_autocmd({
							"CursorHold",
							"CursorHoldI",
						}, {
							group = highlight_group,
							buffer = bufnr,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({
							"CursorMoved",
							"CursorMovedI",
						}, {
							group = highlight_group,
							buffer = bufnr,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- ====================================================
					-- Semantic tokens
					-- ====================================================

					if client:supports_method("textDocument/semanticTokens/full") then
						vim.lsp.semantic_tokens.start(bufnr, client.id)
					end

					-- ====================================================
					-- Completion / navigation capabilities
					-- ====================================================

					if client:supports_method("textDocument/completion") then
						vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
					end

					if client:supports_method("textDocument/definition") then
						vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
					end
				end,
			})

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

				pyright = {
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
		end,
	},
}
