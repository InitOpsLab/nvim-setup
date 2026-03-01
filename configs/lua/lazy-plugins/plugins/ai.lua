-- ~/.config/nvim/lua/lazy-plugins/plugins/ai.lua

local licensed = require("config.licensed")

local plugins = {
	-- 🛠️ Visual Refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("refactoring").setup()
		end,
	},

	-- 📋 Symbol Outline
	{
		"stevearc/aerial.nvim",
		cmd = { "AerialToggle", "AerialOpen" },
		keys = {
			{ "<leader>co", "<cmd>AerialToggle<cr>", desc = "Toggle Code Outline" },
		},
		config = function()
			require("aerial").setup()
		end,
	},
}

-- 🤖 Sidekick (Claude / other AI CLIs) — requires Anthropic subscription
if licensed.sidekick then
	table.insert(plugins, {
		"folke/sidekick.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.sidekick")
		end,
	})
end

return plugins
