-- ~/.config/nvim/lua/options.lua
-- Centralized editor options

local opt = vim.opt

-- ============================================
-- Clipboard
-- ============================================
opt.clipboard = "unnamedplus"

-- ============================================
-- Search
-- ============================================
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- ============================================
-- Folding (Treesitter-based)
-- ============================================
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "0" -- Hide fold column (cleaner UI)

-- ============================================
-- Indentation
-- ============================================
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true

-- ============================================
-- UI / Display
-- ============================================
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.linebreak = true -- Wrap at word boundaries (when wrap=true)
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false -- Hidden (shown in statusline)
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 1
opt.pumheight = 10 -- Max completion popup height
opt.pumblend = 10 -- Popup transparency
opt.winblend = 10 -- Floating window transparency
opt.colorcolumn = "120" -- Line length indicator

-- ============================================
-- Performance
-- ============================================
opt.updatetime = 250
opt.timeoutlen = 300 -- Faster which-key popup
opt.redrawtime = 1500
opt.lazyredraw = false -- Disable (can cause issues with some plugins)

-- ============================================
-- Files & Undo
-- ============================================
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.writebackup = false -- Don't create backup before overwriting

-- ============================================
-- Splits
-- ============================================
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen" -- Keep text on screen when splitting

-- ============================================
-- Completion
-- ============================================
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c") -- Don't show completion messages

-- ============================================
-- Visuals
-- ============================================
opt.termguicolors = true
opt.conceallevel = 0 -- Show text normally (no concealing)
opt.list = true -- Show whitespace characters
opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	extends = "›",
	precedes = "‹",
}
opt.fillchars = {
	eob = " ", -- Hide ~ on empty lines
	fold = " ",
	foldopen = "▼",
	foldclose = "▶",
	foldsep = " ",
	diff = "╱",
	vert = "│",
}

-- ============================================
-- Grep (use ripgrep if available)
-- ============================================
if vim.fn.executable("rg") == 1 then
	opt.grepprg = "rg --vimgrep --smart-case --hidden"
	opt.grepformat = "%f:%l:%c:%m"
end

-- ============================================
-- Misc
-- ============================================
opt.mouse = "a" -- Enable mouse
opt.mousemoveevent = true -- Track mouse movement
opt.virtualedit = "block" -- Allow cursor beyond EOL in visual block
opt.inccommand = "split" -- Preview substitutions live
opt.confirm = true -- Confirm before closing unsaved buffers
opt.formatoptions = "jcroqlnt" -- Better formatting

-- Disable intro message
opt.shortmess:append("I")

-- ============================================
-- Keymaps (core, non-plugin)
-- ============================================
local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better movement
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Buffers
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })

-- Don't yank on paste in visual mode
map("x", "p", [["_dP]], { desc = "Paste without yanking" })

-- Quick save
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- ============================================
-- Autocommands
-- ============================================
local augroup = vim.api.nvim_create_augroup("UserOptions", { clear = true })

-- Dynamic line numbering (relative in Normal, absolute in Insert)
vim.api.nvim_create_autocmd("InsertEnter", {
	group = augroup,
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = augroup,
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Auto-resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = {
		"help",
		"man",
		"lspinfo",
		"checkhealth",
		"qf",
		"query",
		"notify",
		"spectre_panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-- Set filetype for specific files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup,
	pattern = { "*.env", "*.env.*" },
	callback = function()
		vim.opt_local.filetype = "sh"
	end,
})
