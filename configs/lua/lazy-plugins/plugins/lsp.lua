-- ~/.config/nvim/lua/lazy-plugins/plugins/lsp.lua
return {
  -- Treesitter (syntax, folding expr source)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },

  -- LSP core
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Capabilities (completion)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      pcall(function()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      end)

      -- on_attach: keymaps + organize imports (Go)
      local on_attach = function(_, bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "<F12>", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "gr", vim.lsp.buf.references, "Find References")
        map("n", "<S-F12>", vim.lsp.buf.references, "Find References")
        map("n", "K", vim.lsp.buf.hover, "Hover Docs")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

        map("n", "gvd", function() vim.cmd("vsplit"); vim.lsp.buf.definition() end, "Definition in vsplit")
        map("n", "gvr", function() vim.cmd("vsplit"); vim.lsp.buf.references() end, "References in vsplit")
        map("n", "gtd", function() vim.cmd("tab split"); vim.lsp.buf.definition() end, "Definition in new tab")
        map("n", "gtr", function() vim.cmd("tab split"); vim.lsp.buf.references() end, "References in new tab")

        map("n", "<leader>oi", function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
        end, "Organize Imports (Go)")
      end

      require("mason").setup()
      local mlsp = require("mason-lspconfig")
      mlsp.setup({
        ensure_installed = {
          "lua_ls", "pyright", "ts_ls", "bashls", "yamlls", "jsonls",
          "terraformls", "gopls", "sqlls",
        },
        automatic_installation = true,
      })

      local function setup_server(server)
        local opts = { on_attach = on_attach, capabilities = capabilities }

        if server == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          }
        elseif server == "gopls" then
          opts.settings = {
            gopls = {
              gofumpt = true,
              usePlaceholders = true,
              staticcheck = true,
              directoryFilters = { "-vendor" },
              analyses = {
                unusedparams = true, nilness = true, shadow = true, unusedwrite = true, useany = true,
              },
              hints = {
                assignVariableTypes = true, compositeLiteralFields = true, compositeLiteralTypes = true,
                constantValues = true, functionTypeParameters = true, parameterNames = true, rangeVariableTypes = true,
              },
              codelenses = {
                gc_details = true, generate = true, run_govulncheck = true, test = true,
                tidy = true, upgrade_dependency = true, vendor = true,
              },
            },
          }
        end

        -- tsserver/ts_ls compatibility
        if server == "ts_ls" and not lspconfig[server] and lspconfig["tsserver"] then
          server = "tsserver"
        elseif server == "tsserver" and not lspconfig[server] and lspconfig["ts_ls"] then
          server = "ts_ls"
        end

        if lspconfig[server] then
          lspconfig[server].setup(opts)
        end
      end

      if type(mlsp.setup_handlers) == "function" then
        mlsp.setup_handlers({ function(server) setup_server(server) end })
      else
        local installed = {}
        pcall(function() installed = mlsp.get_installed_servers() end)
        for _, server in ipairs(installed or {}) do setup_server(server) end
      end
    end,
  },

  -- (Dependencies declared above; no separate mason specs needed)
}

