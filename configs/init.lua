vim.g.mapleader = " "

-- === Core Settings ===
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- === Plugin Loader ===
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- === Format Shortcut ===
vim.keymap.set("n", "<leader>f", function()
  require("conform").format()
end, { noremap = true, silent = true })

-- === Keybindings for Tools ===
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File Tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Toggle Terminal
map("n", "<leader>t", ":ToggleTerm<CR>", opts)

-- Harpoon
map("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", opts)
map("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
map("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", opts)
map("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", opts)

-- Spectre (Search & Replace)
map("n", "<leader>S", ":lua require('spectre').toggle()<CR>", opts)

-- Todo Comments
map("n", "<leader>td", ":TodoTelescope<CR>", opts)

-- Markdown Preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", opts)

-- Telescope Finders
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Noice Command Line History
map("n", "<leader>nl", ":Noice<CR>", opts)

