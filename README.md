# 🧠 Neovim DevSecOps Configuration (Lazy.nvim + SOPS + LSP)

This is a fully featured, modern Neovim configuration optimized for **DevOps and DevSecOps workflows**.

Built on top of [`Lazy.nvim`](https://github.com/folke/lazy.nvim) and structured for clarity and maintainability, it includes rich support for:

- Encrypted file editing with [SOPS](https://github.com/mozilla/sops)
- YAML, JSON, Terraform, HCL, Markdown
- Language Server Protocol (LSP), completion, and formatting
- Live previewing Markdown and Mermaid diagrams
- Modular UI, productivity tools, Git integration, and more

---

## 📁 Project Structure

The configuration is split into modular components under `~/.config/nvim`.

```
~/.config/nvim/
├── init.lua                         # Entry point
├── lua/
│   ├── options.lua                  # Core editor settings
│   ├── config/                      # Plugin configs
│   │   ├── toggleterm.lua
│   │   ├── harpoon.lua
│   │   ├── markdown.lua
│   │   ├── schemastore.lua
│   │   └── sops.lua                 # Custom: decrypt/edit/encrypt via SOPS
│   └── lazy-plugins/                # Lazy plugin definitions
│       ├── init.lua
│       ├── lsp.lua
│       ├── dev.lua
│       ├── tools.lua
│       └── ui.lua
setup.sh                             # Tooling setup (macOS & Ubuntu)
```

Each plugin has its own isolated config. The system is designed for **ease of extension**.

---

## 🛠 Features

### 🔐 SOPS Integration
- Securely edit encrypted `.yaml`, `.json`, or `.env` files using `:SopsEdit` and `:SopsVsplit`
- Temp files are uniquely named per buffer
- Re-encryption happens automatically on save
- Clipboard-friendly editing using `+` register

### 💡 LSP + Dev Tools
- Managed via `mason.nvim` and `nvim-lspconfig`
- Built-in support for:
  - YAML, JSON, Bash, Terraform, Python, Lua
  - Auto-formatters: `black`, `prettier`, `shfmt`, `terraform_fmt`
  - Completion with `nvim-cmp` + `LuaSnip`

### 📊 UI + UX
- Theme: `catppuccin`
- Statusline: `lualine`
- Popups & notifications: `noice.nvim`, `nvim-notify`
- Keybindings: `which-key`
- Tabline, bufferline, TODO highlighter, color previews

### 🔍 Navigation & Git
- `telescope.nvim` for fuzzy file search, live grep
- `nvim-tree.lua` file explorer
- `harpoon` for fast buffer jumping
- Git: `vim-fugitive`, `gitsigns.nvim`

### 📄 Markdown + Mermaid
- Live Markdown preview with Mermaid diagram support via `markdown-preview.nvim` and `@mermaid-js/mermaid-cli`
- Auto-installs Mermaid CLI via `npm`

---

## 🧩 Plugin Management with Lazy.nvim

Lazy.nvim is used as the core plugin manager. Plugins are grouped logically:

| File                   | Responsibility                  |
|------------------------|----------------------------------|
| `lsp.lua`              | LSP, mason, mason-lspconfig      |
| `dev.lua`              | Treesitter, cmp, snippets        |
| `tools.lua`            | Markdown, autopairs, toggleterm  |
| `ui.lua`               | Theme, UI plugins, notifications |
| `init.lua` (loader)    | Registers plugin sets            |

Run `:Lazy` to explore and manage plugins in Neovim.

---

## 🚀 Installation

### 1. Clone the Repo

```bash
git clone https://github.com/your-user/neovim-devsecops.git
cd neovim-devsecops
chmod +x setup.sh
./setup.sh
```

This sets up everything under `~/.config/nvim` and installs required tools:

- Neovim, Git, Node, Python
- `ripgrep`, `jq`, `fd`, `terraform`, `lua-language-server`
- `sops`, `age`, `mmdc` (mermaid CLI)

> Compatible with macOS (Homebrew) and Ubuntu (APT)

### 2. Launch Neovim

```vim
:Lazy sync
:checkhealth
```

This installs and checks plugin health.

---

## 🔐 Encrypted File Editing (SOPS)

### SOPS Commands

| Command             | Description                                 |
|---------------------|---------------------------------------------|
| `:SopsEdit <file>`  | Decrypt and edit a SOPS file                |
| `:SopsVsplit <file>`| Decrypt and open in a vertical split        |

> Decrypted buffers are saved to `/tmp/sops-<hash>-<filename>` and auto re-encrypted on save.

### SOPS Shortcuts

| Shortcut       | Description                                  |
|----------------|----------------------------------------------|
| `<leader>se`   | Prompt: decrypt & open                       |
| `<leader>sv`   | Prompt: vertical-split a decrypted file      |
| `<leader>sy`   | Copy full buffer to system clipboard         |
| `<leader>sp`   | Paste clipboard into buffer                  |

---

## 🧠 Usage Cheatsheet

### Tabs & Splits

| Command       | Description             |
|---------------|--------------------------|
| `:tabnew`     | Open new tab            |
| `gt` / `gT`   | Next / previous tab     |
| `:vsplit`     | Vertical split          |
| `Ctrl+w h/j/k/l` | Move between splits |

### Telescope

| Shortcut      | Description              |
|---------------|--------------------------|
| `<leader>ff`  | Fuzzy find file          |
| `<leader>fg`  | Live grep                |
| `<leader>fb`  | Buffer search            |
| `<leader>fh`  | Help tag search          |

### Markdown

| Command              | Description                        |
|----------------------|------------------------------------|
| `:MarkdownPreview`   | Start live preview in browser      |
| `:MarkdownPreviewStop` | Stop preview                    |
| `mmdc -i foo.mmd -o out.svg` | Render Mermaid via CLI     |

---

## ⚙️ Customization

You can extend or override anything by:

- Adding new plugin configs to `lua/config/`
- Adding new plugin groups in `lazy-plugins/`
- Creating new commands or mappings in `init.lua`

Each component is isolated, discoverable, and minimal.

---

## 🧼 Cleanup

To reset or remove all config + plugins:

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
```

---

## 📜 License

MIT License.  
Use freely, adapt for your team or company use.

---

## 🤝 Contributions

If you'd like to contribute additional plugins, language support, or SOPS features, feel free to open an issue or PR.


