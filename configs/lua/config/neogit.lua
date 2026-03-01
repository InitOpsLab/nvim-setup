local ok, neogit = pcall(require, "neogit")
if not ok then return end

neogit.setup({
  integrations = {
    diffview = true,
    telescope = true,
  },
  signs = {
    hunk = { "", "" },
    item = { ">", "v" },
    section = { ">", "v" },
  },
})

-- Keymaps
local map = vim.keymap.set

-- Open Neogit status (main interface)
map("n", "<leader>gg", function() neogit.open() end, { desc = "Neogit status" })

-- Quick actions
map("n", "<leader>gc", function() neogit.open({ "commit" }) end, { desc = "Git commit" })
map("n", "<leader>gp", function() neogit.open({ "pull" }) end, { desc = "Git pull" })
map("n", "<leader>gP", function() neogit.open({ "push" }) end, { desc = "Git push" })
map("n", "<leader>gb", function() neogit.open({ "branch" }) end, { desc = "Git branch" })
map("n", "<leader>gl", function() neogit.open({ "log" }) end, { desc = "Git log" })
map("n", "<leader>gS", function() neogit.open({ "stash" }) end, { desc = "Git stash" })
