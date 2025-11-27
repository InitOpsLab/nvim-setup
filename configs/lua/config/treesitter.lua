-- ~/.config/nvim/lua/config/treesitter.lua

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "json",
    "yaml",
    "lua",
    "python",
    "hcl",
    "terraform",
    "sql",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "go",
    "gomod",
    "ruby",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "json" }, -- can add "yaml", "hcl" if needed
  },
  -- Note: autotag requires nvim-ts-autotag plugin
  -- Note: matchup requires vim-matchup plugin
})

