-- ~/.config/nvim/lua/lazy-plugins/plugins/ui.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- Colorscheme must load at startup
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Must load at startup for directory browsing
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      require("config.nvim-tree")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false, -- Statusline should load at startup
    config = function()
      require("config.lualine")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
    config = function()
      require("config.gitsigns")
    end,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit Status" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git Commit" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Git Pull" },
      { "<leader>gd", "<cmd>Neogit diff<cr>", desc = "Git Diff" },
      { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Git Branches" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("config.neogit")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  --------------------------------------------------------------------------
  -- 🐙 GitHub Integration (PRs, Issues, Reviews, Actions)
  --------------------------------------------------------------------------
  {
    "topaxi/gh-actions.nvim",
    cmd = "GhActions",
    keys = {
      { "<leader>ga", "<cmd>GhActions<cr>", desc = "GitHub Actions" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("gh-actions").setup()
    end,
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    keys = {
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>gr", "<cmd>Octo review start<cr>", desc = "Start PR Review" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        enable_builtin = true,
        default_to_projects_v2 = true,
        picker = "telescope",
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("config.telescope")
    end,
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep()  end, desc = "Live grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers()    end, desc = "Find buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags()  end, desc = "Find help" },
    },
  },
}

