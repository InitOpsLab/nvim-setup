-- ~/.config/nvim/lua/lazy-plugins/plugins/tools.lua
return {
	--------------------------------------------------------------------------
	-- 🖥️ Terminal Integration
	--------------------------------------------------------------------------
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
		},
		config = function()
			require("config.toggleterm")
		end,
	},

	--------------------------------------------------------------------------
	-- 📂 Enhanced Folding (JSON, YAML, HCL, etc.)
	--------------------------------------------------------------------------
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Use treesitter as primary provider, indent as fallback
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
				-- Show fold preview with virtual text
				fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
					local newVirtText = {}
					local suffix = ("  %d lines "):format(endLnum - lnum)
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0
					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if targetWidth > curWidth + chunkWidth then
							table.insert(newVirtText, chunk)
						else
							chunkText = truncate(chunkText, targetWidth - curWidth)
							local hlGroup = chunk[2]
							table.insert(newVirtText, { chunkText, hlGroup })
							chunkWidth = vim.fn.strdisplaywidth(chunkText)
							if curWidth + chunkWidth < targetWidth then
								suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
							end
							break
						end
						curWidth = curWidth + chunkWidth
					end
					table.insert(newVirtText, { suffix, "MoreMsg" })
					return newVirtText
				end,
			})

			-- Keymaps
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
			vim.keymap.set("n", "zK", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end, { desc = "Peek fold or hover" })
		end,
	},

	--------------------------------------------------------------------------
	-- 📎 File Navigation
	--------------------------------------------------------------------------
	{
		"ThePrimeagen/harpoon",
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add File" },
			{ "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
			{ "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Navigate to file 1" },
			{ "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Navigate to file 2" },
			{ "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Navigate to file 3" },
			{ "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Navigate to file 4" },
		},
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
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
			{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
		},
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
		build = function(plugin)
			vim.fn["mkdp#util#install"]()
			-- Prevent yarn.lock from blocking Lazy updates
			local lock = plugin.dir .. "/app/yarn.lock"
			if vim.uv.fs_stat(lock) then
				os.remove(lock)
			end
		end,
		ft = { "markdown" },
		config = function()
			require("config.markdown")
			local file = vim.fn.expand("%:p")
			if file:match("%.mmd$") and vim.fn.exists(":MarkdownPreview") == 2 then
				vim.cmd("MarkdownPreview")
			end
		end,
	},

	--------------------------------------------------------------------------
	-- 🔍 Trouble (Better Diagnostics List)
	--------------------------------------------------------------------------
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.trouble")
		end,
	},

	--------------------------------------------------------------------------
	-- ⚡ Flash (Enhanced Navigation)
	--------------------------------------------------------------------------
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("config.flash")
		end,
	},

	--------------------------------------------------------------------------
	-- 💾 Persistence (Session Management)
	--------------------------------------------------------------------------
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = function()
			require("config.persistence")
		end,
	},

	--------------------------------------------------------------------------
	-- 🔄 Project-Wide Find & Replace
	--------------------------------------------------------------------------
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search & Replace (grug-far)" },
		},
		opts = {},
	},
}
