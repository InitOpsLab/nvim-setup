-- ~/.config/nvim/lua/config/copilot.lua

local copilot = require("copilot")

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<C-l>",
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-]>",
    },
  },
  panel = {
    enabled = true,
    auto_refresh = true,
  },
  filetypes = {
    markdown = true,
    help = true,
    gitcommit = true,
    gitrebase = true,
    yaml = true,
    ["*"] = true, -- enable everywhere
  },
})

