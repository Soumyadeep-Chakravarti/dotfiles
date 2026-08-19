return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "json",
                "lua",
                "markdown",
                "nix",
                "python",
                "rust",
                "toml",
                "vim",
                "yaml",
            },
        },

        config = function(_, opts)
            require("nvim-treesitter").install(opts.ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local ok = pcall(vim.treesitter.start)
                    if not ok then
                        return
                    end

                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
