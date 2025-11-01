-- lua/config/go.lua
local ok, go = pcall(require, "go")
if not ok then return end

go.setup({
  goimport        = "goimports",
  fillstruct      = "gopls",
  lsp_inlay_hints = { enable = false },  -- Disable inlay hints
})

vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", { noremap=true, silent=true })

