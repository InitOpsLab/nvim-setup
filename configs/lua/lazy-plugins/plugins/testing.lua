-- ~/.config/nvim/lua/lazy-plugins/plugins/testing.lua
return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
			"olimorris/neotest-rspec",
		},
		cmd = { "Neotest" },
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Test: Run Nearest" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run File" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: Toggle Summary" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Show Output" },
			{ "<leader>tS", function() require("neotest").run.stop() end, desc = "Test: Stop" },
		},
		config = function()
			require("config.neotest")
		end,
	},
}
