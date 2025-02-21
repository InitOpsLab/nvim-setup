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
local ensure_packer = function()
  local fn = vim.fn
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
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "jose-elias-alvarez/null-ls.nvim"
  use "mfussenegger/nvim-dap"
  use "nvim-lualine/lualine.nvim"
  use "nvim-tree/nvim-web-devicons"
  use "nvim-lua/plenary.nvim"

  -- Additional requested plugins
  use "stevearc/conform.nvim"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "catppuccin/nvim"
  use "akinsho/bufferline.nvim"
  use "rebelot/heirline.nvim"
  use "RRethy/vim-illuminate"
  use "echasnovski/mini.indentscope"
  use "nvim-telescope/telescope.nvim"
  use "christoomey/vim-sort-motion"
  use "michaeljsmith/vim-indent-object"
  use "bkad/CamelCaseMotion"
  use "wellle/targets.vim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Treesitter Configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vim", "lua", "html", "css", "javascript", "typescript", "tsx",
    "c", "python", "markdown", "markdown_inline"
  },
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["ma"] = "@parameter.inner",
        ["mc"] = "@class.outer",
        ["mi"] = "@conditional.inner",
        ["md"] = "@function.outer",
        ["ms"] = "@block.outer",
      },
      swap_previous = {
        ["Ma"] = "@parameter.inner",
        ["Mc"] = "@class.outer",
        ["Mi"] = "@conditional.inner",
        ["Md"] = "@function.outer",
        ["Ms"] = "@block.outer",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ad"] = "@function.outer",
        ["id"] = "@function.inner",
        ["as"] = "@block.outer",
        ["is"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { ["]a"] = "@parameter.outer", ["]c"] = "@class.outer", ["]d"] = "@function.outer", ["]s"] = "@block.outer" },
      goto_previous_start = { ["[a"] = "@parameter.outer", ["[c"] = "@class.outer", ["[d"] = "@function.outer", ["[s"] = "@block.outer" },
    },
  },
})

-- Mason setup for LSPs
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "pyright", "lua_ls" } })

