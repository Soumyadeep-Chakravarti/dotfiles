return {
    "lervag/vimtex",
    ft = "tex",
    init = function()
        vim.cmd[[let g:vimtex_view_general_viewer = 'zathura']]
        vim.cmd[[set conceallevel=2]]
        vim.cmd[[let g:tex_conceal='abdmg']]
    end,
}
