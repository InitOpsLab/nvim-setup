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

  -- === Formatting ===
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },
          json = { "prettier" },
          yaml = { "prettier" },
          bash = { "shfmt" },
          sql = { "sqlfmt" },
          terraform = { "terraform_fmt" },
          hcl = { "terraform_fmt" },
        },
      })
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

  -- === Motion & Editing ===
  "tpope/vim-commentary",
  "jiangmiao/auto-pairs",
  "michaeljsmith/vim-indent-object",
  "wellle/targets.vim",
  "bkad/CamelCaseMotion",
  "christoomey/vim-sort-motion",

  -- === Productivity Boosters ===
  { "folke/which-key.nvim", opts = {} }, 
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
    end
  },
  { "ThePrimeagen/harpoon" },

  -- === Comfort Plugins ===
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
     require("ibl").setup({
       scope = {
         enabled = true,
         show_start = false,
         show_end = false,
       },
       indent = {
         char = "│",
       }
     })
   end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end
  },

  -- Optional UX polish
  "lewis6991/impatient.nvim",
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    config = function()
      require("noice").setup({})
    end
  },
}

