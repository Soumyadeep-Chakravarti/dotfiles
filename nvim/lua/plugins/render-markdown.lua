return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        opts = {
            heading = {
                sign = false,
                icons = { "◉ ", "○ ", "✸ ", "✿ " },
            },
            code = {
                sign = false,
                width = "block",
                right_pad = 4,
            },
            checkbox = {
                enabled = true,
            },
        },
    },
}
