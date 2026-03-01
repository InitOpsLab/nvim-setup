-- ~/.config/nvim/lua/config/refactor.lua

-- Refactoring keymap (visual mode)
vim.keymap.set("v", "<leader>rr", function()
  require("refactoring").select_refactor()
end, { desc = "Refactor: select action" })

-- Extract function (visual)
vim.keymap.set("v", "<leader>re", function()
  require("refactoring").refactor("Extract Function")
end, { desc = "Refactor: Extract Function" })

-- Extract variable (visual)
vim.keymap.set("v", "<leader>rv", function()
  require("refactoring").refactor("Extract Variable")
end, { desc = "Refactor: Extract Variable" })

-- Inline variable
vim.keymap.set({ "n", "v" }, "<leader>ri", function()
  require("refactoring").refactor("Inline Variable")
end, { desc = "Refactor: Inline Variable" })

-- Extract block
vim.keymap.set("n", "<leader>rb", function()
  require("refactoring").refactor("Extract Block")
end, { desc = "Refactor: Extract Block" })
