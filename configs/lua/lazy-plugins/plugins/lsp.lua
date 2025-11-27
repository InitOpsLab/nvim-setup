-- ~/.config/nvim/lua/lazy-plugins/plugins/lsp.lua
return {
	--------------------------------------------------------------------------
	-- 🌳 Treesitter
	--------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},

	--------------------------------------------------------------------------
	-- ⚙️ Core LSP (Modern Neovim API)
	--------------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			----------------------------------------------------------------------
			-- ✅ Modern LSP API (Neovim 0.11+)
			----------------------------------------------------------------------
			-- Use vim.lsp.config instead of require("lspconfig") for Neovim 0.11+

			-- Capabilities (completion)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local cmp_lsp = require("cmp_nvim_lsp")
			if cmp_lsp and cmp_lsp.default_capabilities then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end

			-- Diagnostics configuration
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = false,
				underline = true,
				signs = true,
				float = { border = "rounded" },
				update_in_insert = false,
				severity_sort = true,
			})

			-- Common on_attach keymaps
			local function on_attach(client, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
				end

				-- LSP mappings
				map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
				map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
				map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
				map("n", "gr", vim.lsp.buf.references, "Find References")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

				-- Enhanced K: show diagnostics if any, otherwise hover
				map("n", "K", function()
					local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
					local diags = vim.diagnostic.get(0, { lnum = lnum })
					if #diags > 0 then
						vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
					else
						vim.lsp.buf.hover()
					end
				end, "Diagnostics (if any) or Hover")

				-- Organize imports
				map("n", "<leader>oi", function()
					vim.lsp.buf.code_action({
						apply = true,
						context = { only = { "source.organizeImports" } },
					})
				end, "Organize Imports")

				-- Note: Format on save handled by conform.nvim (config/conform.lua)
			end

			----------------------------------------------------------------------
			-- 🧰 Mason setup
			----------------------------------------------------------------------
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			local mason_lspconfig = require("mason-lspconfig")

			----------------------------------------------------------------------
			-- Server-specific configurations
			----------------------------------------------------------------------
			local servers = {
				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},

				-- Go
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							staticcheck = true,
							usePlaceholders = true,
							directoryFilters = { "-vendor" },
							hints = {
								assignVariableTypes = false,
								compositeLiteralFields = false,
								compositeLiteralTypes = false,
								constantValues = false,
								functionTypeParameters = false,
								parameterNames = false,
								rangeVariableTypes = false,
							},
							analyses = {
								unusedparams = false,
								shadow = false,
							},
						},
					},
				},

				-- Python
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},

				-- YAML
				yamlls = {
					settings = {
						yaml = {
							schemas = require("schemastore").yaml.schemas(),
							validate = true,
							format = { enable = true },
							hover = true,
							completion = true,
							-- Disable telemetry
							redhat = {
								telemetry = {
									enabled = false,
								},
							},
						},
					},
				},

				-- JSON
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				-- Terraform
				terraformls = {
					cmd = { "terraform-ls", "serve" },
					filetypes = { "terraform", "terraform-vars", "hcl" },
				},

				-- TypeScript/JavaScript (using ts_ls instead of deprecated tsserver)
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},

				-- Ruby
				solargraph = {
					settings = {
						solargraph = {
							diagnostics = true,
						},
					},
				},
			}

			----------------------------------------------------------------------
			-- Setup all servers (Modern Neovim 0.11+ API)
			----------------------------------------------------------------------
			local setup_server = function(server_name)
				local server_opts = vim.tbl_deep_extend("force", {
					on_attach = on_attach,
					capabilities = capabilities,
				}, servers[server_name] or {})

				-- Use modern vim.lsp.config API (Neovim 0.11+)
				-- Note: vim.lsp.config is the modern API, but setup works the same way
				local ok, err = pcall(function()
					-- Try modern API first, fall back to require if needed
					local config = vim.lsp.config or require("lspconfig")
					if config[server_name] and config[server_name].setup then
						config[server_name].setup(server_opts)
					else
						vim.notify(
							"LSP: server '" .. server_name .. "' not available",
							vim.log.levels.WARN
						)
					end
				end)

				if not ok then
					vim.notify(
						"LSP: failed to setup '" .. server_name .. "': " .. tostring(err),
						vim.log.levels.ERROR
					)
				end
			end

			----------------------------------------------------------------------
			-- Mason LSP config setup
			----------------------------------------------------------------------
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"pyright",
					"yamlls",
					"jsonls",
					"terraformls",
					"ts_ls", -- Modern TypeScript server name
					"bashls",
					"sqlls",
					"solargraph",
				},
				automatic_installation = true,
				handlers = {
					-- Default handler for all servers
					function(server_name)
						setup_server(server_name)
					end,
				},
			})

		end,
	},
}
