-- ~/.config/nvim/lua/config/conform.lua

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		json = { "prettier" },
		yaml = { "prettier" },
		bash = { "shfmt" },
		sql = { "sqlfmt" },
		terraform = { "terraform_fmt" },
		hcl = { "terraform_fmt" },
		ruby = { "rubocop" },
		markdown = { "prettier" },
		go = { "gofumpt", "goimports", "golines" },
	},

	format_on_save = {
		timeout_ms = 1000,
		lsp_fallback = true,
	},
})
