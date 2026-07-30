return {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead *",
    config = function()
        require("colorizer").setup({
            filetypes = { "*" },
        })
    end,
}
