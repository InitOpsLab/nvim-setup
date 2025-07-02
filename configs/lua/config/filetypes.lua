-- ~/.config/nvim/lua/config/filetypes.lua

-- Detect Helm templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "**/templates/*.tpl",
  command = "set filetype=helm",
})

-- Detect Go templating
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tpl",
  callback = function(args)
    local lines = vim.fn.readfile(args.file, "", 5)
    local content = table.concat(lines, "\n")

    if content:find("{{.-}}") then
      vim.bo.filetype = "gotmpl"
    elseif content:find("resource") and content:find("=") then
      vim.bo.filetype = "terraform"
    else
      vim.bo.filetype = "html"
    end
  end,
})

-- Detect mmd as Markdown
vim.filetype.add({
  extension = {
    mmd = "markdown",
  },
})

