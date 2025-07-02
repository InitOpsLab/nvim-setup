-- ~/.config/nvim/lua/config/go.lua
local ok, go = pcall(require, "go")
if not ok then return end

go.setup({
  goimport        = "goimports",   -- or "gofumpt"
  fillstruct      = "gopls",
  lsp_inlay_hints = { enable = true },
})

-- Example keymap to run tests under cursor
vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", { noremap=true, silent=true })

