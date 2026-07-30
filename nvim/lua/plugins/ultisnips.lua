return {
    "SirVer/ultisnips",
    event = "BufReadPre",
    init = function()
        vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. "/.config/nvim/UltiSnips", "UltiSnips" }
    end,
    dependencies = {
        "honza/vim-snippets",
    },
}
