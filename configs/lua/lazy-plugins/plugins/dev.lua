-- ~/.config/nvim/lua/lazy-plugins/plugins/dev.lua

return {
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip" },
	{ "stevearc/conform.nvim" },
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{ "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
	},
	{ "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" } },
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{ "jbyuki/one-small-step-for-vimkind" }, -- optional Lua debugging
}
