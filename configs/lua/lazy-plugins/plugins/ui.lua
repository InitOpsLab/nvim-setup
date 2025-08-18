-- ~/.config/nvim/lua/lazy-plugins/plugins/ui.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree") -- create lua/config/nvim-tree.lua if you want custom opts
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine") -- or inline as you had
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns") -- optional: keep your current {}
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.telescope") -- optional: or keep {} inline
    end,
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep()  end, desc = "Live grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers()    end, desc = "Find buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags()  end, desc = "Find help" },
    },
  },
}

