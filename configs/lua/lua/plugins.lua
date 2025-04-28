-- ~/.config/nvim/lua/plugins.lua

-- ~/.config/nvim/lua/plugins.lua

return {
  -- === LSP + Dev ===
  "neovim/nvim-lspconfig",
  { "williamboman/mason.nvim", config = true },
  "williamboman/mason-lspconfig.nvim",

  -- === Autocomplete ===
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- === Treesitter ===
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")  -- Import treesitter config
    end
  },

  -- === UI Enhancements ===
  "nvim-lualine/lualine.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "catppuccin/nvim",
  "akinsho/bufferline.nvim",
  "rebelot/heirline.nvim",
  "RRethy/vim-illuminate",

  -- === Git Tools ===
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",

  -- === Markdown + Mermaid Preview ===
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_preview_options = {
        mermaid = { enable = true, executable = "mmdc", options = "--theme dark" }
      }
    end
  },
  
  -- other plugins...
}

