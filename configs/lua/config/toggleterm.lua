-- ~/.config/nvim/lua/config/toggleterm.lua

local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  direction = "horizontal",
  start_in_insert = true,
  persist_size = true,
  shading_factor = 2,
})

-- Lazygit terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "rounded",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

vim.keymap.set("n", "<leader>gz", function() lazygit:toggle() end, { desc = "Lazygit" })

