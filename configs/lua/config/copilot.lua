-- ~/.config/nvim/lua/config/copilot.lua

local copilot = require("copilot")

copilot.setup({
	copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/fnm/node-versions/v22.21.1/installation/bin/node",
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
