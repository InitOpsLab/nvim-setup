-- ~/.config/nvim/lua/config/lsp.lua

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = { "pyright" },
})

-- Manually set up Pyright (safe even on older versions)
lspconfig.pyright.setup({})

