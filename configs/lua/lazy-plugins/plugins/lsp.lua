-- ~/.config/nvim/lua/lazy-plugins/plugins/lsp.lua
return {
	--------------------------------------------------------------------------
	-- 🌳 Treesitter (syntax highlighting, folding, etc.)
	--------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},

	--------------------------------------------------------------------------
	-- ⚙️ Core LSP Configuration
	--------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspStart", "LspStop" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			-- Always prefer the new 0.11 API
			local lsp = vim.lsp.config

			-- Completion capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			pcall(function()
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			end)

			-- Common LSP keymaps
			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end
				map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
				map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
				map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
				map("n", "gr", vim.lsp.buf.references, "Find References")
				map("n", "K", vim.lsp.buf.hover, "Hover Docs")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("n", "<leader>oi", function()
					vim.lsp.buf.code_action({
						apply = true,
						context = { only = { "source.organizeImports" } },
					})
				end, "Organize Imports")
			end

			----------------------------------------------------------------------
			-- 🧰 Mason setup
			----------------------------------------------------------------------
			require("mason").setup()
			local mlsp = require("mason-lspconfig")

			mlsp.setup({
				ensure_installed = {
					-- 🧠 General language servers
					"lua_ls", -- Lua
					"pyright", -- Python
					"tsserver", -- JavaScript/TypeScript
					"bashls", -- Bash
					"yamlls", -- YAML
					"jsonls", -- JSON / SchemaStore
					"gopls", -- Go
					"solargraph", -- Ruby
					"terraformls", -- HCL / Terraform
					"sqlls", -- SQL
				},
				automatic_installation = true,
			})

			----------------------------------------------------------------------
			-- 🧠 Mason LSP Setup Handlers
			----------------------------------------------------------------------
			mlsp.setup_handlers({
				function(server)
					local opts = { on_attach = on_attach, capabilities = capabilities }

					-- Lua
					if server == "lua_ls" then
						opts.settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
							},
						}

					-- Go
					elseif server == "gopls" then
						opts.settings = {
							gopls = {
								gofumpt = true,
								staticcheck = true,
								usePlaceholders = true,
								directoryFilters = { "-vendor" },
							},
						}

					-- Python
					elseif server == "pyright" then
						opts.settings = {
							python = {
								analysis = {
									typeCheckingMode = "basic",
									autoSearchPaths = true,
									useLibraryCodeForTypes = true,
								},
							},
						}

					-- Ruby
					elseif server == "solargraph" then
						opts.settings = { solargraph = { diagnostics = true } }

					-- YAML
					elseif server == "yamlls" then
						local schemastore = require("schemastore")
						opts.settings = {
							yaml = {
								schemas = schemastore.yaml.schemas(),
								validate = true,
							},
						}

					-- JSON
					elseif server == "jsonls" then
						local schemastore = require("schemastore")
						opts.settings = {
							json = {
								schemas = schemastore.json.schemas(),
								validate = { enable = true },
							},
						}

					-- HCL / Terraform
					elseif server == "terraformls" then
						opts.cmd = { "terraform-ls", "serve" }
						opts.filetypes = { "terraform", "hcl", "tf", "tfvars" }
					end

					if lsp[server] and lsp[server].setup then
						lsp[server].setup(opts)
					else
						vim.notify("LSP setup skipped: " .. server, vim.log.levels.WARN)
					end
				end,
			})
		end,
	},
}
