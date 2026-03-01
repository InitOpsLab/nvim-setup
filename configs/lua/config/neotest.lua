-- ~/.config/nvim/lua/config/neotest.lua

require("neotest").setup({
	adapters = {
		require("neotest-go"),
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-jest")({
			jestCommand = "npx jest",
		}),
		require("neotest-rspec"),
	},
})
