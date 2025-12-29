-- Jira plugin declaration for Lazy.nvim
-- Place in: ~/.config/nvim/lua/lazy-plugins/plugins/jira.lua

return {
  {
    name = "jira",
    dir = vim.fn.stdpath("config") .. "/lua/config",
    
    ft = { "jira", "markdown" },
    
    cmd = { "Jira" },
    
    keys = {
      { "<leader>jn", "<cmd>Jira new<cr>", desc = "Jira: New ticket" },
      { "<leader>js", "<cmd>Jira submit<cr>", desc = "Jira: Submit" },
      { "<leader>jm", "<cmd>Jira my<cr>", desc = "Jira: My issues" },
      { "<leader>jv", "<cmd>Jira view<cr>", desc = "Jira: View issue" },
      { "<leader>jo", "<cmd>Jira open<cr>", desc = "Jira: Open in browser" },
    },
    
    config = function()
      require("config.jira").setup({
        -- Customize options here
        terminal_direction = "float",
      })
    end,
  },
}
