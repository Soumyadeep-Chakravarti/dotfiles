return {
    {
        "kevalin/mermaid.nvim",
        ft = { "markdown" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            output_dir = "/tmp/mermaid-nvim",
        },
        config = function(_, opts)
            require("mermaid").setup(opts)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.keymap.set("n", "<leader>mc", "<cmd>MermaidCmd<CR>", {
                        buffer = true,
                        desc = "Compile and Preview Mermaid Block",
                    })
                end,
            })
        end,
    },
}
