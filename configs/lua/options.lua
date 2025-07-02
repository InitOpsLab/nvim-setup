vim.opt.clipboard = "unnamedplus"
-- Enable fold expr for Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Make folds actually usable at startup
vim.opt.foldenable = true          -- important!
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- ~/.config/nvim/lua/options.lua

vim.opt.clipboard = "unnamedplus"

-- Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

