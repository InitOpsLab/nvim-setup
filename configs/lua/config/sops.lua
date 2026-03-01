-- ~/.config/nvim/lua/config/sops.lua

-- === Helpers ===

local function absolute(path)
  return vim.fn.fnamemodify(path, ":p")
end

local function check_file_exists(path)
  if vim.fn.filereadable(path) == 0 then
    print("❌ File not found: " .. path)
    return false
  end
  return true
end

local function decrypt_to_tmp(original)
  local uv = vim.uv or vim.loop
  local hash = vim.fn.sha256(original .. os.time() .. uv.os_getpid())
  local tmp = "/tmp/sops-" .. hash:sub(1, 12) .. "-" .. vim.fn.fnamemodify(original, ":t")
  os.execute(string.format("sops -d '%s' > '%s'", original, tmp))
  return tmp
end

local function setup_auto_encrypt(tmpfile, original)
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = tmpfile,
    callback = function()
      os.execute(string.format("sops -e '%s' > '%s'", tmpfile, original))
      print("🔐 Re-encrypted: " .. original)
    end,
  })
end

-- === Commands ===

-- :SopsEdit <file> — decrypt + open in current window
vim.api.nvim_create_user_command("SopsEdit", function(opts)
  local filepath = absolute(opts.args)
  if not check_file_exists(filepath) then return end

  local tmpfile = decrypt_to_tmp(filepath)
  vim.cmd("edit " .. tmpfile)
  setup_auto_encrypt(tmpfile, filepath)
end, { nargs = 1, complete = "file" })

-- :SopsVsplit <file> — decrypt + open in vertical split
vim.api.nvim_create_user_command("SopsVsplit", function(opts)
  local filepath = absolute(opts.args)
  if not check_file_exists(filepath) then return end

  local tmpfile = decrypt_to_tmp(filepath)
  vim.cmd("vsplit " .. tmpfile)
  setup_auto_encrypt(tmpfile, filepath)
end, { nargs = 1, complete = "file" })

-- === Keybindings ===

-- <leader>se — prompt to open encrypted file
vim.keymap.set("n", "<leader>se", function()
  vim.ui.input({ prompt = "🔐 SOPS Edit File: " }, function(input)
    if input then vim.cmd("SopsEdit " .. input) end
  end)
end, { desc = "SOPS Edit Encrypted File" })

-- <leader>sv — prompt to vsplit an encrypted file
vim.keymap.set("n", "<leader>sv", function()
  vim.ui.input({ prompt = "🔐 SOPS VSplit File: " }, function(input)
    if input then vim.cmd("SopsVsplit " .. input) end
  end)
end, { desc = "SOPS VSplit Encrypted File" })

-- <leader>sy — yank entire buffer to system clipboard
vim.keymap.set("n", "<leader>sy", function()
  vim.cmd("%y+")
  print("📋 Copied buffer to clipboard (+ register)")
end, { desc = "Copy Decrypted Buffer to Clipboard" })

-- <leader>sp — paste clipboard into buffer
vim.keymap.set({ "n", "i" }, "<leader>sp", '"+p', { desc = "Paste from Clipboard into Buffer" })

