-- ~/.config/nvim/lua/config/sidekick.lua
-- Sidekick (Claude / AI CLI) configuration tuned for a Mac laptop

local ok, sidekick = pcall(require, "sidekick")
if not ok then
	return
end

local root_patterns = require("config.roots")
local workspace_dir = vim.fn.expand("$HOME/.cache/nvim/workspaces")

--- Resolve workspace symlinks into real project paths.
local function get_workspace_project_dirs()
	local cwd = vim.fn.getcwd()
	local dirs = {}

	-- If cwd is inside a workspace dir, resolve all symlinks as project dirs
	if cwd:find(workspace_dir, 1, true) == 1 then
		local handle = vim.uv.fs_scandir(cwd)
		if handle then
			while true do
				local name, type = vim.uv.fs_scandir_next(handle)
				if not name then
					break
				end
				if type == "link" or type == "directory" then
					local real_path = vim.fn.resolve(cwd .. "/" .. name)
					if vim.fn.isdirectory(real_path) == 1 then
						dirs[real_path] = true
					end
				end
			end
		end
	end

	return dirs
end

--- Collect unique project roots from all loaded buffers, excluding cwd.
local function get_extra_project_dirs()
	local roots = get_workspace_project_dirs()
	local cwd = vim.fn.getcwd()

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if name ~= "" then
				local found = vim.fs.find(root_patterns, { upward = true, path = name })[1]
				if found then
					local root = vim.fs.dirname(found)
					if root and root ~= cwd and not roots[root] then
						roots[root] = true
					end
				end
			end
		end
	end

	local args = {}
	for root, _ in pairs(roots) do
		table.insert(args, "--add-dir")
		table.insert(args, root)
	end
	return args
end

--- Build the claude cmd array with --add-dir flags for all open projects.
local function claude_cmd()
	local cmd = { "claude" }
	for _, arg in ipairs(get_extra_project_dirs()) do
		table.insert(cmd, arg)
	end
	return cmd
end

--- Update the claude tool cmd in sidekick's config and return.
local function refresh_claude_cmd()
	local Config = require("sidekick.config")
	Config.cli.tools.claude.cmd = claude_cmd()
end

sidekick.setup({
	cli = {
		watch = true,
		tools = {
			claude = { cmd = claude_cmd() },
		},
	},
})

-- ---------------------------------------------------------------------------
-- Keymaps (Mac-friendly, centered around <leader>m)
-- ---------------------------------------------------------------------------

local cli = require("sidekick.cli")

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		noremap = true,
		silent = true,
		desc = desc,
	})
end

-- Toggle Claude (all modes)
map({ "n", "t", "i", "x" }, "<C-.>", function()
	cli.toggle({ name = "claude", focus = true })
end, "AI: Toggle Claude")

map("n", "<leader>mm", function()
	cli.toggle({ name = "claude", focus = true })
end, "AI: Toggle Claude")

-- Restart Claude with freshly detected project dirs
-- (use after opening new projects mid-session)
map("n", "<leader>mc", function()
	cli.close({ name = "claude" })
	refresh_claude_cmd()
	vim.defer_fn(function()
		cli.toggle({ name = "claude", focus = true })
	end, 300)
end, "AI: Restart Claude (fresh dirs)")

-- Select AI tool (Claude, Gemini, Copilot CLI, etc.)
map("n", "<leader>ms", function()
	cli.select()
end, "AI: Select CLI tool")

-- Send context to Claude
map({ "n", "x" }, "<leader>mt", function()
	cli.send({ msg = "{this}" })
end, "AI: Send 'this'")

map("n", "<leader>mf", function()
	cli.send({ msg = "{file}" })
end, "AI: Send file")

-- Prompt picker (explain, fix, tests, etc.)
map({ "n", "x" }, "<leader>mp", function()
	cli.prompt()
end, "AI: Prompt picker")
