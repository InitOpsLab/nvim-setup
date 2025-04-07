-- ~/.config/nvim/lua/config/markdown.lua

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_browser = "default"
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_port = ""
vim.g.mkdp_page_title = "Markdown Preview"

-- Optional Mermaid support
vim.g.mkdp_preview_options = {
  mermaid = {
    enable = true,
    executable = "mmdc",
    options = "--theme dark"
  }
}

