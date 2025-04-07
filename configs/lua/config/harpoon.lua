-- ~/.config/nvim/lua/config/harpoon.lua

-- ✅ Harpoon v2 module-based API
local ok_ui, harpoon_ui = pcall(require, "harpoon.ui")
local ok_mark, harpoon_mark = pcall(require, "harpoon.mark")

if not (ok_ui and ok_mark) then
  return
end

-- Keybindings
vim.keymap.set("n", "<leader>a", harpoon_mark.add_file, { desc = "Harpoon Add File" })
vim.keymap.set("n", "<C-e>", harpoon_ui.toggle_quick_menu, { desc = "Harpoon Menu" })

vim.keymap.set("n", "<leader>1", function() harpoon_ui.nav_file(1) end, { desc = "Navigate to file 1" })
vim.keymap.set("n", "<leader>2", function() harpoon_ui.nav_file(2) end, { desc = "Navigate to file 2" })
vim.keymap.set("n", "<leader>3", function() harpoon_ui.nav_file(3) end, { desc = "Navigate to file 3" })
vim.keymap.set("n", "<leader>4", function() harpoon_ui.nav_file(4) end, { desc = "Navigate to file 4" })

