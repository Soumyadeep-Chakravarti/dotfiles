vim.opt.langmap = "+]ü["

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.undofile = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.scrolloff = 5

vim.opt.termguicolors = true
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.errorbells = false
vim.opt.hidden = true
vim.opt.iskeyword:append("-")
vim.opt.encoding = "UTF-8"

vim.g.python3_host_prog = "/home/sammy/.venv/bin/python3"

vim.cmd[[let g:loaded_ruby_provider = 0]]
vim.cmd[[let g:loaded_perl_provider = 0]]
vim.cmd[[let g:loaded_node_provider = 0]]
vim.deprecate = function() end
