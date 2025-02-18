-- Leader key
vim.g.mapleader = ','

-- Load `.vimrc` for compatibility
vim.cmd('source ~/.vimrc')

-- Set up runtime paths
vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.opt.packpath = vim.opt.runtimepath:get()

-- UI Enhancements
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Ensure Packer is installed
local ensure_packer = function()local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Load Packer
local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

-- Plugin Management
packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Packer manages itself
  use "nvim-treesitter/nvim-treesitter"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip"
  use "jose-elias-alvarez/null-ls.nvim"
  use "mfussenegger/nvim-dap"
  use "nvim-lualine/lualine.nvim"
  use "nvim-tree/nvim-web-devicons"
  use "nvim-lua/plenary.nvim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Treesitter Configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"python", "terraform", "bash", "yaml", "json", "lua", "rego"},
    highlight = { enable = true },
    indent = { enable = true }
}

-- Mason setup for installing LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "terraformls", "bashls", "yamlls", "jsonls", "lua_ls" }
})

-- Debugging with nvim-dap
local dap = require("dap")
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()return "python"
    end,
  },
}

-- Lualine Setup
require('lualine').setup {
  options = { theme = 'gruvbox' }
}


