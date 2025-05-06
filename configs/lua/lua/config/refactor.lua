-- ~/.config/nvim/lua/config/refactor.lua

-- Refactoring keymap (visual mode)
vim.keymap.set("v", "<leader>rr", function()
  require("refactoring").select_refactor()
end, { desc = "Refactor: select action" })

-- Symbol outline toggle
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle Symbol Outline" })

