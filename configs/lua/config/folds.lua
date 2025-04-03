-- ~/.config/nvim/lua/config/folds.lua

-- Default: Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Fallback: use indent-based folding for HCL/Terraform
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "hcl", "terraform" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldexpr = ""
  end,
})

-- Auto-close all folds when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    -- Use silent to avoid flicker
    vim.cmd("silent! normal! zM")
  end,
})

