-- ~/.config/nvim/lua/lazy-plugins/plugins/tools.lua
return {
	--------------------------------------------------------------------------
	-- 🖥️ Terminal Integration
	--------------------------------------------------------------------------
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("config.toggleterm")
		end,
	},

	--------------------------------------------------------------------------
	-- 📎 File Navigation
	--------------------------------------------------------------------------
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("config.harpoon")
		end,
	},

	--------------------------------------------------------------------------
	-- 🧩 SchemaStore (JSON & YAML)
	--------------------------------------------------------------------------
	{
		"b0o/schemastore.nvim",
		config = function()
			local lsp = vim.lsp.config or require("lspconfig")
			local schemastore = require("schemastore")

			if lsp.jsonls and lsp.jsonls.setup then
				lsp.jsonls.setup({
					settings = {
						json = {
							schemas = schemastore.json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end

			if lsp.yamlls and lsp.yamlls.setup then
				lsp.yamlls.setup({
					settings = {
						yaml = {
							schemas = schemastore.yaml.schemas(),
							validate = true,
						},
					},
				})
			end
		end,
	},

	--------------------------------------------------------------------------
	-- 💬 Commenting
	--------------------------------------------------------------------------
	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {},
	},

	--------------------------------------------------------------------------
	-- 🪄 Autopairs (brackets, quotes)
	--------------------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}
