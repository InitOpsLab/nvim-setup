local ok, persistence = pcall(require, "persistence")
if not ok then return end

persistence.setup({
  dir = vim.fn.stdpath("state") .. "/sessions/",
  need = 1,
  branch = true,
})

local map = vim.keymap.set

map("n", "<leader>qs", function() persistence.load() end, { desc = "Restore Session" })
map("n", "<leader>qS", function() persistence.select() end, { desc = "Select Session" })
map("n", "<leader>ql", function() persistence.load({ last = true }) end, { desc = "Restore Last Session" })
map("n", "<leader>qd", function() persistence.stop() end, { desc = "Don't Save Current Session" })
