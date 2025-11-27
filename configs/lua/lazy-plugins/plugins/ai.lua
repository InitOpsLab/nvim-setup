-- ~/.config/nvim/lua/lazy-plugins/plugins/ai.lua

return {
	-- 🤖 GitHub Copilot core
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("config.copilot")
		end,
	},

	-- 🤝 Copilot + nvim-cmp integration
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- 🛠️ Visual Refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("refactoring").setup()
		end,
	},

	-- 📋 Symbol Outline
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	},

	-- 🤖 Sidekick (Claude / other AI CLIs)
	{
		"folke/sidekick.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.sidekick")
		end,
	},
}
