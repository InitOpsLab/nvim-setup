-- ~/.config/nvim/lua/lazy-plugins/plugins/ai.lua

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("config.copilot")
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- 🛠️ Visual Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("refactoring").setup()
    end,
  },

  -- 📋 Symbol Outline
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
    end,
  },
}
