-- ~/.config/nvim/lua/config/wdn.lua
-- Warp point navigation from within Neovim (integrates with ~/.warprc)

local M = {}

local warprc_path = vim.fn.expand("$HOME/.warprc")
local workspace_dir = vim.fn.expand("$HOME/.cache/nvim/workspaces")

-- Expand ~ to home directory
local function expand_tilde(path)
	if path:sub(1, 1) == "~" then
		return vim.fn.expand("$HOME") .. path:sub(2)
	end
	return path
end

-- Parse warprc file and return table of {name = path}
local function parse_warprc()
	local warp_points = {}
	local file = io.open(warprc_path, "r")
	if not file then
		return warp_points
	end

	for line in file:lines() do
		-- Skip empty lines and comments
		if line ~= "" and not line:match("^#") and line:match(":") then
			local name, path = line:match("^%s*(.-)%s*:%s*(.-)%s*$")
			if name and path then
				-- Later entries override earlier ones (same behavior as wdn)
				warp_points[name] = expand_tilde(path)
			end
		end
	end
	file:close()
	return warp_points
end

-- Get sorted list of warp points for display
local function get_warp_list()
	local warp_points = parse_warprc()
	local list = {}
	for name, path in pairs(warp_points) do
		table.insert(list, { name = name, path = path })
	end
	table.sort(list, function(a, b)
		return a.name < b.name
	end)
	return list
end

-- Create a workspace with symlinks to multiple projects
local function create_workspace(projects)
	if #projects == 0 then
		return nil
	end

	-- Create workspace directory if it doesn't exist
	vim.fn.mkdir(workspace_dir, "p")

	-- Create a unique workspace name based on project names
	local ws_name = table.concat(
		vim.tbl_map(function(p)
			return p.name
		end, projects),
		"+"
	)
	local ws_path = workspace_dir .. "/" .. ws_name

	-- Clean up existing workspace with same name
	if vim.fn.isdirectory(ws_path) == 1 then
		vim.fn.delete(ws_path, "rf")
	end
	vim.fn.mkdir(ws_path, "p")

	-- Create symlinks to each project
	for _, project in ipairs(projects) do
		local link_path = ws_path .. "/" .. project.name
		local target_path = project.path
		-- Remove existing link if any
		if vim.fn.filereadable(link_path) == 1 or vim.fn.isdirectory(link_path) == 1 then
			vim.fn.delete(link_path)
		end
		-- Create symlink
		vim.fn.system({ "ln", "-s", target_path, link_path })
	end

	return ws_path, ws_name
end

-- Change directory to warp point (creates workspace for consistency)
local function goto_warp(name)
	local warp_points = parse_warprc()
	local path = warp_points[name]
	if path and vim.fn.isdirectory(path) == 1 then
		-- Create workspace with single project (allows adding more later)
		local ws_path, _ = create_workspace({ { name = name, path = path } })
		if ws_path then
			vim.cmd("cd " .. vim.fn.fnameescape(ws_path))
			vim.notify("Switched to: " .. name, vim.log.levels.INFO)

			-- Refresh nvim-tree if available
			pcall(function()
				require("nvim-tree.api").tree.change_root(ws_path)
				require("nvim-tree.api").tree.reload()
			end)
		end
		return true
	else
		vim.notify("wdn: no such warp point or directory: " .. name, vim.log.levels.ERROR)
		return false
	end
end

-- Check if currently in a workspace and return its info
local function get_current_workspace()
	local cwd = vim.fn.getcwd()
	if cwd:find(workspace_dir, 1, true) == 1 then
		-- We're in a workspace, get the projects from symlinks
		local ws_path = cwd
		local projects = {}
		local handle = vim.uv.fs_scandir(ws_path)
		if handle then
			while true do
				local name, type = vim.uv.fs_scandir_next(handle)
				if not name then
					break
				end
				if type == "link" or type == "directory" then
					local link_path = ws_path .. "/" .. name
					local real_path = vim.fn.resolve(link_path)
					if vim.fn.isdirectory(real_path) == 1 then
						table.insert(projects, { name = name, path = real_path })
					end
				end
			end
		end
		return { path = ws_path, projects = projects }
	end
	return nil
end

-- Add projects to current workspace
function M.add_to_workspace(project_names)
	local warp_points = parse_warprc()
	local current_ws = get_current_workspace()

	if not current_ws then
		vim.notify("Not in a workspace. Open a project with 'wdn <project>' first.", vim.log.levels.WARN)
		return
	end

	-- Gather existing projects
	local all_projects = {}
	local existing_names = {}
	for _, p in ipairs(current_ws.projects) do
		table.insert(all_projects, p)
		existing_names[p.name] = true
	end

	-- Add new projects
	local added = {}
	for _, name in ipairs(project_names) do
		if not existing_names[name] then
			local path = warp_points[name]
			if path and vim.fn.isdirectory(path) == 1 then
				table.insert(all_projects, { name = name, path = path })
				table.insert(added, name)
				existing_names[name] = true
			else
				vim.notify("wdn: skipping invalid warp point: " .. name, vim.log.levels.WARN)
			end
		end
	end

	if #added == 0 then
		vim.notify("No new projects to add", vim.log.levels.INFO)
		return
	end

	-- Recreate workspace with all projects
	local ws_path, ws_name = create_workspace(all_projects)
	if ws_path then
		vim.cmd("cd " .. vim.fn.fnameescape(ws_path))
		vim.notify("Added to workspace: " .. table.concat(added, ", "), vim.log.levels.INFO)

		-- Refresh nvim-tree if available
		pcall(function()
			require("nvim-tree.api").tree.change_root(ws_path)
			require("nvim-tree.api").tree.reload()
		end)
	end
end

-- Remove projects from current workspace
function M.remove_from_workspace(project_names)
	local current_ws = get_current_workspace()

	if not current_ws then
		vim.notify("Not in a workspace.", vim.log.levels.WARN)
		return
	end

	if #current_ws.projects <= 1 then
		vim.notify("Cannot remove the only project in workspace.", vim.log.levels.WARN)
		return
	end

	-- Filter out removed projects
	local remaining_projects = {}
	local removed = {}
	local remove_set = {}
	for _, name in ipairs(project_names) do
		remove_set[name] = true
	end

	for _, p in ipairs(current_ws.projects) do
		if remove_set[p.name] then
			table.insert(removed, p.name)
		else
			table.insert(remaining_projects, p)
		end
	end

	if #removed == 0 then
		vim.notify("No matching projects to remove", vim.log.levels.INFO)
		return
	end

	-- Recreate workspace without removed projects
	local ws_path, ws_name = create_workspace(remaining_projects)
	if ws_path then
		vim.cmd("cd " .. vim.fn.fnameescape(ws_path))
		vim.notify("Removed from workspace: " .. table.concat(removed, ", "), vim.log.levels.INFO)

		-- Refresh nvim-tree if available
		pcall(function()
			require("nvim-tree.api").tree.change_root(ws_path)
			require("nvim-tree.api").tree.reload()
		end)
	end
end

-- Telescope picker to remove projects from current workspace
function M.telescope_remove_from_workspace()
	local current_ws = get_current_workspace()
	if not current_ws then
		vim.notify("Not in a workspace.", vim.log.levels.WARN)
		return
	end

	if #current_ws.projects <= 1 then
		vim.notify("Cannot remove the only project in workspace.", vim.log.levels.WARN)
		return
	end

	local ok, _ = pcall(require, "telescope")
	if not ok then
		vim.notify("Telescope required for workspace picker", vim.log.levels.ERROR)
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Remove from Workspace (Tab to multi-select)",
			finder = finders.new_table({
				results = current_ws.projects,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.name,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local picker = action_state.get_current_picker(prompt_bufnr)
					local multi_selections = picker:get_multi_selection()

					actions.close(prompt_bufnr)

					local selected_names = {}
					if #multi_selections > 0 then
						for _, selection in ipairs(multi_selections) do
							table.insert(selected_names, selection.value.name)
						end
					else
						local selection = action_state.get_selected_entry()
						if selection then
							table.insert(selected_names, selection.value.name)
						end
					end

					if #selected_names > 0 then
						M.remove_from_workspace(selected_names)
					end
				end)
				return true
			end,
		})
		:find()
end

-- Telescope picker to add projects to current workspace
function M.telescope_add_to_workspace()
	local current_ws = get_current_workspace()
	if not current_ws then
		vim.notify("Not in a workspace. Open a project with 'wdn <project>' first.", vim.log.levels.WARN)
		return
	end

	local ok, _ = pcall(require, "telescope")
	if not ok then
		vim.notify("Telescope required for workspace picker", vim.log.levels.ERROR)
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	-- Get warp points not already in workspace
	local existing_names = {}
	for _, p in ipairs(current_ws.projects) do
		existing_names[p.name] = true
	end

	local warp_list = {}
	for _, entry in ipairs(get_warp_list()) do
		if not existing_names[entry.name] then
			table.insert(warp_list, entry)
		end
	end

	if #warp_list == 0 then
		vim.notify("All warp points already in workspace", vim.log.levels.INFO)
		return
	end

	pickers
		.new({}, {
			prompt_title = "Add to Workspace (Tab to multi-select)",
			finder = finders.new_table({
				results = warp_list,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.name,
						ordinal = entry.name .. " " .. entry.path,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local picker = action_state.get_current_picker(prompt_bufnr)
					local multi_selections = picker:get_multi_selection()

					actions.close(prompt_bufnr)

					local selected_names = {}
					if #multi_selections > 0 then
						for _, selection in ipairs(multi_selections) do
							table.insert(selected_names, selection.value.name)
						end
					else
						local selection = action_state.get_selected_entry()
						if selection then
							table.insert(selected_names, selection.value.name)
						end
					end

					if #selected_names > 0 then
						M.add_to_workspace(selected_names)
					end
				end)
				return true
			end,
		})
		:find()
end

-- Open workspace with multiple projects
function M.open_workspace(project_names)
	local warp_points = parse_warprc()
	local projects = {}

	for _, name in ipairs(project_names) do
		local path = warp_points[name]
		if path and vim.fn.isdirectory(path) == 1 then
			table.insert(projects, { name = name, path = path })
		else
			vim.notify("wdn: skipping invalid warp point: " .. name, vim.log.levels.WARN)
		end
	end

	if #projects == 0 then
		vim.notify("wdn: no valid projects selected", vim.log.levels.ERROR)
		return
	end

	if #projects == 1 then
		-- Just one project, use normal goto
		goto_warp(projects[1].name)
		return
	end

	local ws_path, ws_name = create_workspace(projects)
	if ws_path then
		vim.cmd("cd " .. vim.fn.fnameescape(ws_path))
		vim.notify("Workspace: " .. ws_name .. " (" .. #projects .. " projects)", vim.log.levels.INFO)

		-- Refresh nvim-tree if available
		pcall(function()
			require("nvim-tree.api").tree.change_root(ws_path)
			require("nvim-tree.api").tree.reload()
		end)
	end
end

-- Telescope picker with multi-select for workspaces
function M.telescope_workspace()
	local ok, _ = pcall(require, "telescope")
	if not ok then
		vim.notify("Telescope required for workspace picker", vim.log.levels.ERROR)
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local warp_list = get_warp_list()

	pickers
		.new({}, {
			prompt_title = "Select Projects (Tab to multi-select, Enter to open)",
			finder = finders.new_table({
				results = warp_list,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.name,
						ordinal = entry.name .. " " .. entry.path,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local picker = action_state.get_current_picker(prompt_bufnr)
					local multi_selections = picker:get_multi_selection()

					actions.close(prompt_bufnr)

					local selected_names = {}
					if #multi_selections > 0 then
						-- Use multi-selected items
						for _, selection in ipairs(multi_selections) do
							table.insert(selected_names, selection.value.name)
						end
					else
						-- Use single selection
						local selection = action_state.get_selected_entry()
						if selection then
							table.insert(selected_names, selection.value.name)
						end
					end

					if #selected_names > 0 then
						M.open_workspace(selected_names)
					end
				end)
				return true
			end,
		})
		:find()
end

-- Telescope picker for warp points
function M.telescope_wdn()
	local ok, telescope = pcall(require, "telescope")
	if not ok then
		vim.notify("Telescope not available, using vim.ui.select", vim.log.levels.WARN)
		M.select_wdn()
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local warp_list = get_warp_list()

	pickers
		.new({}, {
			prompt_title = "Warp Points (wdn)",
			finder = finders.new_table({
				results = warp_list,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.name,
						ordinal = entry.name .. " " .. entry.path,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						goto_warp(selection.value.name)
					end
				end)
				return true
			end,
		})
		:find()
end

-- Fallback using vim.ui.select
function M.select_wdn()
	local warp_list = get_warp_list()
	local items = {}
	for _, entry in ipairs(warp_list) do
		table.insert(items, string.format("%-20s -> %s", entry.name, entry.path))
	end

	vim.ui.select(items, { prompt = "Select warp point:" }, function(choice, idx)
		if choice and warp_list[idx] then
			goto_warp(warp_list[idx].name)
		end
	end)
end

-- List warp points
function M.list()
	local warp_list = get_warp_list()
	if #warp_list == 0 then
		vim.notify("No warp points found in " .. warprc_path, vim.log.levels.WARN)
		return
	end
	local lines = { "Warp points:" }
	for _, entry in ipairs(warp_list) do
		table.insert(lines, string.format("  %-20s -> %s", entry.name, entry.path))
	end
	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

-- Add current directory as warp point
function M.add(name)
	if not name or name == "" then
		vim.ui.input({ prompt = "Warp point name: " }, function(input)
			if input and input ~= "" then
				M.add(input)
			end
		end)
		return
	end

	local cwd = vim.fn.getcwd()
	local file = io.open(warprc_path, "a")
	if file then
		file:write(string.format("%s:%s\n", name, cwd))
		file:close()
		vim.notify("Added warp point '" .. name .. "' -> " .. cwd, vim.log.levels.INFO)
	else
		vim.notify("Failed to write to " .. warprc_path, vim.log.levels.ERROR)
	end
end

-- Remove warp point
function M.remove(name)
	if not name or name == "" then
		vim.notify("wdn rm: missing name", vim.log.levels.ERROR)
		return
	end

	local file = io.open(warprc_path, "r")
	if not file then
		return
	end

	local lines = {}
	local found = false
	for line in file:lines() do
		local k = line:match("^%s*(.-)%s*:")
		if k ~= name then
			table.insert(lines, line)
		else
			found = true
		end
	end
	file:close()

	if found then
		file = io.open(warprc_path, "w")
		if file then
			file:write(table.concat(lines, "\n") .. "\n")
			file:close()
			vim.notify("Removed warp point '" .. name .. "'", vim.log.levels.INFO)
		end
	else
		vim.notify("Warp point '" .. name .. "' not found", vim.log.levels.WARN)
	end
end

-- Setup commands
function M.setup()
	-- Main command with subcommands
	-- :Wdn              - picker to switch project
	-- :Wdn <project>    - switch to project (replaces workspace)
	-- :Wdn add          - picker to add projects to workspace
	-- :Wdn add <p1> ... - add projects to workspace
	-- :Wdn remove       - picker to remove projects from workspace
	-- :Wdn remove <p1>  - remove projects from workspace
	-- :Wdn ls           - list warp points
	vim.api.nvim_create_user_command("Wdn", function(opts)
		local args = opts.fargs
		local subcmd = args[1]

		if not subcmd or subcmd == "" then
			M.telescope_wdn()
		elseif subcmd == "ls" or subcmd == "list" then
			M.list()
		elseif subcmd == "add" then
			-- Add to current workspace
			if #args > 1 then
				local project_names = { unpack(args, 2) }
				M.add_to_workspace(project_names)
			else
				M.telescope_add_to_workspace()
			end
		elseif subcmd == "remove" then
			-- Remove from current workspace
			if #args > 1 then
				local project_names = { unpack(args, 2) }
				M.remove_from_workspace(project_names)
			else
				M.telescope_remove_from_workspace()
			end
		else
			-- Treat as warp point name - switch to it
			goto_warp(subcmd)
		end
	end, {
		nargs = "*",
		complete = function(arglead, cmdline, cursorpos)
			local args = vim.split(cmdline, "%s+")
			if #args <= 2 then
				-- Complete subcommands and warp point names
				local completions = { "ls", "add", "remove" }
				local warp_points = parse_warprc()
				for name, _ in pairs(warp_points) do
					table.insert(completions, name)
				end
				return vim.tbl_filter(function(item)
					return item:find(arglead, 1, true) == 1
				end, completions)
			elseif args[2] == "add" then
				-- Complete warp point names for add
				local warp_points = parse_warprc()
				local names = {}
				for name, _ in pairs(warp_points) do
					table.insert(names, name)
				end
				return vim.tbl_filter(function(item)
					return item:find(arglead, 1, true) == 1
				end, names)
			elseif args[2] == "remove" then
				-- Complete with current workspace project names
				local current_ws = get_current_workspace()
				if current_ws then
					local names = {}
					for _, p in ipairs(current_ws.projects) do
						table.insert(names, p.name)
					end
					return vim.tbl_filter(function(item)
						return item:find(arglead, 1, true) == 1
					end, names)
				end
			end
			return {}
		end,
	})

	-- Keymaps
	vim.keymap.set("n", "<leader>wp", M.telescope_wdn, { desc = "Switch project" })
	vim.keymap.set("n", "<leader>wa", M.telescope_add_to_workspace, { desc = "Add to workspace" })
	vim.keymap.set("n", "<leader>wr", M.telescope_remove_from_workspace, { desc = "Remove from workspace" })
end

-- Auto-setup
M.setup()

return M
