-- ~/.config/nvim/lua/config/treesitter.lua

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "json", "yaml", "hcl", "terraform", "python", "bash", "lua"
  },
  highlight = { enable = true },
  indent = {
    enable = true,
  },
  autotag = { enable = true },
})

