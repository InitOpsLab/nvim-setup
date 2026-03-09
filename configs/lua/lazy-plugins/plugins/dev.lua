-- ~/.config/nvim/lua/lazy-plugins/plugins/dev.lua

local licensed = require("config.licensed")

local cmp_deps = {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"L3MON4D3/LuaSnip",
}
if licensed.copilot then
	table.insert(cmp_deps, "zbirenbaum/copilot-cmp")
end

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = cmp_deps,
		config = function()
			require("config.cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", lazy = true },
	{ "hrsh7th/cmp-buffer", lazy = true },
	{ "L3MON4D3/LuaSnip", lazy = true },
	-- Copilot — requires GitHub Copilot subscription
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		enabled = licensed.copilot,
		config = function()
			require("config.copilot")
		end,
	},
	{ "zbirenbaum/copilot-cmp", lazy = true, enabled = licensed.copilot },
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.conform")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lint")
		end,
	},
	{ "mfussenegger/nvim-dap", cmd = { "DapContinue", "DapToggleBreakpoint" } },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{ "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
	},
	{ "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" } },
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{ "jbyuki/one-small-step-for-vimkind", cmd = "OSVLaunch" }, -- optional Lua debugging
}
