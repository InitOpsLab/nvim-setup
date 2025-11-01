-- ~/.config/nvim/lua/config/lsp.lua

local mason            = require("mason")
local mason_lspconfig  = require("mason-lspconfig")
local lspconfig        = require("lspconfig")

-- Mason & servers
mason.setup()
mason_lspconfig.setup({
  ensure_installed = { "pyright", "gopls" },
})

-- ───────── Diagnostics: no inline clutter ─────────
vim.diagnostic.config({
  virtual_text = false,   -- remove "invalid type" inline text
  virtual_lines = false,  -- no virtual lines below code
  underline    = true,    -- keep squiggly underlines (set false to remove)
  signs        = true,    -- keep signs in the gutter
  float        = { border = "rounded" },
})

-- Press K: diagnostics on this line if any; otherwise normal hover
vim.keymap.set("n", "K", function()
  local lnum  = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })
  if #diags > 0 then
    vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Diagnostics (if any) or Hover" })

-- ───────── LSP servers ─────────

-- Pyright (Python)
lspconfig.pyright.setup({})

-- Go (gopls) - Disabled hover hints and inline information
lspconfig.gopls.setup({
  settings = {
    gopls = {
      -- Disable hover information and inline hints
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
      -- Disable analyses that show inline information
      analyses = { 
        unusedparams = false, 
        shadow = false 
      },
      staticcheck = false,
      -- Disable other features that might show hints
      usePlaceholders = false,
      completeUnimported = false,
      deepCompletion = false,
    },
  },
})
