-- ~/.config/nvim/lua/config/treesitter.lua

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "json", "yaml", "python", "bash", "sql", "hcl", "terraform", "lua"
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

