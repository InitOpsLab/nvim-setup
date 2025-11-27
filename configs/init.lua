-- ~/.config/nvim/init.lua
-- BashBangers Neovim Configuration

-- ============================================
-- 1. LEADER KEYS (Must be first!)
-- ============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================
-- 2. DISABLE NETRW (Before plugins load)
-- ============================================
-- Required if using nvim-tree or neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================
-- 3. LOAD OPTIONS (Before plugins!)
-- ============================================
-- Editor settings should be set before plugins initialize
require("options")

-- ============================================
-- 4. BOOTSTRAP LAZY.NVIM
-- ============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
		}, true, {})
		return
	end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================
-- 5. LOAD PLUGINS VIA LAZY.NVIM
-- ============================================
require("lazy").setup("lazy-plugins.plugins", {
	defaults = { lazy = false },
	install = {
		colorscheme = { "tokyonight", "habamax" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- ============================================
-- 6. LOAD PLUGIN CONFIGS
-- ============================================
-- These run after plugins are loaded
require("config")
