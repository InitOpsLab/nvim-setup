-- ~/.config/nvim/lua/lazy-plugins/init.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "lazy-plugins.plugins" }, -- all plugin specs live under lua/lazy-plugins/plugins/
  },

  -- sensible defaults
  defaults = {
    lazy = false,   -- load plugins immediately unless a spec says otherwise
    version = false -- always use latest (you can lock with lazy-lock.json)
  },

  change_detection = { notify = false }, -- don’t spam when editing your config
  install = { colorscheme = { "catppuccin" } }, -- avoid “no colorscheme” flashes

  performance = {
    rtp = {
      disabled_plugins = { -- trim built-ins you don’t use
        "gzip", "matchit", "matchparen", "tarPlugin", "tohtml", "tutor", "zipPlugin"
      },
    },
  },
})

