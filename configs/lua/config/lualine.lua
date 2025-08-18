local ok, lualine = pcall(require, "lualine")
if not ok then return end
lualine.setup({
  options = {
    theme = "catppuccin",
    section_separators = "",
    component_separators = "",
  },
})
