-- ~/.config/nvim/lua/config/copilot.lua

local copilot = require("copilot")

-- Find Node 22+ for Copilot (required version)
local function find_node_22()
	local fnm_dir = vim.fn.expand("$HOME") .. "/.local/share/fnm/node-versions"

	-- Check if fnm directory exists
	if vim.fn.isdirectory(fnm_dir) == 1 then
		-- Look for v22.x.x directories
		local handle = io.popen("ls -1 " .. vim.fn.shellescape(fnm_dir) .. " 2>/dev/null | grep '^v22' | sort -V | tail -1")
		if handle then
			local result = handle:read("*a"):gsub("%s+", "")
			handle:close()
			if result ~= "" then
				local node_path = fnm_dir .. "/" .. result .. "/installation/bin/node"
				if vim.fn.executable(node_path) == 1 then
					return node_path
				end
			end
		end
	end

	-- Fallback to system node (may not meet version requirement)
	return "node"
end

copilot.setup({
	copilot_node_command = find_node_22(),
	suggestion = {
		enabled = false,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<C-l>",
			next = "<C-n>",
			prev = "<C-p>",
			dismiss = "<C-]>",
		},
	},
	panel = {
		enabled = false,
		auto_refresh = true,
	},
	filetypes = {
		markdown = true,
		help = true,
		gitcommit = true,
		gitrebase = true,
		yaml = true,
		["*"] = true, -- enable everywhere
	},
})
