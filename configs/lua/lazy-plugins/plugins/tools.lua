-- ~/.config/nvim/lua/lazy-plugins/plugins/tools.lua
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("config.toggleterm")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("config.harpoon")
    end,
  },
  {
    "b0o/schemastore.nvim",
    config = function()
      require("config.schemastore")
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      require("config.markdown")
      local file = vim.fn.expand("%:p")
      if file:match("%.mmd$") and vim.fn.exists(":MarkdownPreview") == 2 then
        vim.cmd("MarkdownPreview")
      end
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VimEnter",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "go.work", "go.mod", "Makefile", "package.json", "pyproject.toml" },
        silent_chdir = true,
        manual_mode = false,
        exclude_dirs = { "~/.local/*" },
        show_hidden = true,
      })
      pcall(function() require("telescope").load_extension("projects") end)
    end,
  },
}

