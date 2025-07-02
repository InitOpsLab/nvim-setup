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

