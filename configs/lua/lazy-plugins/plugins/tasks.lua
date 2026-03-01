-- ~/.config/nvim/lua/lazy-plugins/tasks.lua
-- Lazy-loaded note-taking plugins for better startup performance

return {
  {
    "nvim-orgmode/orgmode",
    ft = { "org" }, -- Only load for .org files
    config = function()
      require("orgmode").setup({
        org_agenda_files = { "~/notes/**/*" },
        org_default_notes_file = "~/notes/inbox.org",
        org_todo_keywords = { "TODO", "INPROGRESS", "WAITING", "BLOCKED", "QUESTION", "|", "DONE", "CANCELLED" },
      })
    end,
  },

  {
    "nvim-neorg/neorg",
    ft = { "norg" }, -- Only load for .norg files
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "MunifTanjim/nui.nvim",
      "pysan3/pathlib.nvim",
      "nvim-neorg/lua-utils.nvim",
    },
    config = function()
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
    end,
  },

  {
    "renerocksai/telekasten.nvim",
    cmd = { "Telekasten" }, -- Only load on :Telekasten command
    keys = {
      { "<leader>zf", "<cmd>Telekasten find_notes<cr>", desc = "Find notes" },
      { "<leader>zn", "<cmd>Telekasten new_note<cr>", desc = "New note" },
    },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telekasten").setup({
        home = vim.fn.expand("~/zettelkasten"),
      })
    end,
  },
}

