local ok, telescope = pcall(require, "telescope")
if not ok then return end
telescope.setup({})

-- Find files that do NOT contain a pattern
vim.keymap.set("n", "<leader>fX", function()
  vim.ui.input({ prompt = "Exclude files containing: " }, function(pattern)
    if pattern and pattern ~= "" then
      require("telescope.builtin").find_files({
        find_command = { "rg", "--files-without-match", pattern },
      })
    end
  end)
end, { desc = "Find files NOT containing pattern" })
