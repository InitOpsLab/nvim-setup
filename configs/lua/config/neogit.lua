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

-- Resolve git root from current buffer (follows symlinks for workspace support)
local function git_cwd()
	local buf_path = vim.api.nvim_buf_get_name(0)
	if buf_path == "" then
		buf_path = vim.fn.getcwd()
	end
	-- Resolve symlinks so we get the real path inside an actual git repo
	local real_path = vim.fn.resolve(buf_path)
	local dir = vim.fn.fnamemodify(real_path, ":h")
	-- Find the git root from that directory
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error == 0 and git_root and git_root ~= "" then
		return git_root
	end
	return nil
end

local function neogit_open(args)
	local cwd = git_cwd()
	local opts = args or {}
	if cwd then
		opts.cwd = cwd
	end
	neogit.open(opts)
end

-- Keymaps
local map = vim.keymap.set

-- Open Neogit status (main interface)
map("n", "<leader>gg", function() neogit_open() end, { desc = "Neogit status" })

-- Quick actions
map("n", "<leader>gc", function() neogit_open({ "commit" }) end, { desc = "Git commit" })
map("n", "<leader>gp", function() neogit_open({ "pull" }) end, { desc = "Git pull" })
map("n", "<leader>gP", function() neogit_open({ "push" }) end, { desc = "Git push" })
map("n", "<leader>gb", function() neogit_open({ "branch" }) end, { desc = "Git branch" })
map("n", "<leader>gl", function() neogit_open({ "log" }) end, { desc = "Git log" })
map("n", "<leader>gS", function() neogit_open({ "stash" }) end, { desc = "Git stash" })
