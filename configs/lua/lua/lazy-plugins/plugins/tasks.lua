-- ~/.config/nvim/lua/lazy-plugins/tasks.lua

return {
  {
    "nvim-orgmode/orgmode",
    config = function()
      require("config.tasks")
    end,
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    config = false, -- loaded by config/tasks.lua
  },

  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = false, -- loaded by config/tasks.lua
  },
}

