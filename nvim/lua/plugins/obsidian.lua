return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "vault",
                    path = "~/homelab/Notes/My_Obsidian_notes/",
                },
            },
            finder = "vim.ui.select",
            completion = {
                nvim_cmp = false,
                min_chars = 2,
            },
            ui = {
                enable = true,
                update_debounce = 200,
                checkboxes = {
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = " Diego", hl_group = "ObsidianRightArrow" },
                    ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                },
            },
        },
        config = function(_, opts)
            require("obsidian").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.keymap.set("n", "gf", function()
                        if require("obsidian").util.cursor_on_markdown_link() then
                            return "<cmd>ObsidianFollowLink<CR>"
                        else
                            return "gf"
                        end
                    end, { expr = true, buffer = true, desc = "Follow Link or File" })
                    vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian Note", buffer = true })
                    vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Vault Text", buffer = true })
                    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Note Backlinks", buffer = true })
                    vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename Note and Update Links", buffer = true })
                end,
            })
        end,
    },
}
