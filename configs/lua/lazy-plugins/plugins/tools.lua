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
	-- (no explicit setup here; jsonls/yamlls read schemastore via LSP handlers)
	--------------------------------------------------------------------------
	{ "b0o/schemastore.nvim" },

	--------------------------------------------------------------------------
	-- 💬 Commenting
	--------------------------------------------------------------------------
	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {},
	},

	--------------------------------------------------------------------------
	-- 🪄 Autopairs
	--------------------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	--------------------------------------------------------------------------
	-- 📝 Markdown Preview
	--------------------------------------------------------------------------
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
		config = function()
			require("config.markdown")
			local file = vim.fn.expand("%:p")
			if file:match("%.mmd$") and vim.fn.exists(":MarkdownPreview") == 2 then
				vim.cmd("MarkdownPreview")
			end
		end,
	},
}
