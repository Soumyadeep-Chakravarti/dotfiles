local group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
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

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "gl", vim.diagnostic.open_float, "Show diagnostics")
        map("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")
        map("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")
        map("n", "[e", function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
        end, "Previous error")
        map("n", "]e", function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
        end, "Next error")
        map("n", "[w", function()
            vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN, float = true })
        end, "Previous warning")
        map("n", "]w", function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN, float = true })
        end, "Next warning")
        map("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics location list")
        map("n", "<leader>dx", vim.diagnostic.setqflist, "Diagnostics quickfix list")
        map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
        map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
        map("n", "<leader>li", "<cmd>LspInfo<cr>", "LSP info")
        map("n", "<leader>lr", "<cmd>LspRestart<cr>", "Restart LSP")

        if client:supports_method("textDocument/inlayHint") then
            map("n", "<leader>uh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, "Toggle inlay hints")
        end

        if client:supports_method("textDocument/codeLens") then
            map("n", "<leader>cl", vim.lsp.codelens.run, "Run code lens")
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })
        end

        if client:supports_method("textDocument/documentHighlight") then
            local highlight_group = vim.api.nvim_create_augroup("UserLspDocumentHighlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = highlight_group,
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = highlight_group,
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end

        if client:supports_method("textDocument/semanticTokens/full") then
            vim.lsp.semantic_tokens.start(bufnr, client.id)
        end

        if client:supports_method("textDocument/completion") then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end

        if client:supports_method("textDocument/definition") then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end
    end,
})
