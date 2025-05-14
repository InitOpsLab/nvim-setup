-- ~/.config/nvim/lua/config/tasks.lua

-- Orgmode config
require("orgmode").setup({
  org_agenda_files = { "~/notes/**/*" },
  org_default_notes_file = "~/notes/inbox.org",
})

-- Neorg config (modern core modules)
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},  
    ["core.dirman"] = {       
      config = {
        workspaces = {
          notes = "~/notes",
        },
      },
    },
  },
})

-- Telekasten config
require("telekasten").setup({
  home = vim.fn.expand("~/zettelkasten"),
})

