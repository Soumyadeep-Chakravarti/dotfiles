return {
    "roobert/action-hints.nvim",
    event = "LspAttach",
    config = function()
        require("action-hints").setup({
            use_ic = true,
            icons = {},
        })
    end,
}
