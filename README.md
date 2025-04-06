# 🔐 Neovim DevSecOps Environment (Lazy.nvim + Zsh + SOPS)

A modern, secure, and productive terminal environment built around Neovim, Lazy.nvim, and Zsh — fully equipped for developers, DevOps, and DevSecOps engineers.

---

## ✅ Features

- **Neovim** with `Lazy.nvim` plugin manager
- **LSP**, **completion**, **formatting**, and **Treesitter**
- **Zsh** terminal config with Git, AWS, and SSH shortcuts
- **Markdown live preview** with Mermaid support
- **SOPS integration**: edit encrypted YAML/JSON with auto re-encryption
- **Clipboard support**: yank and paste decrypted content
- **Tab and split navigation**, file trees, fuzzy finder, terminals
- Tools for Terraform, HCL, Docker, K8s, Python, YAML, and more

---

## 🚀 Setup Instructions

### 1. Clone and Run Setup

```bash
git clone https://github.com/your-user/neovim-devsecops.git
cd neovim-devsecops
chmod +x setup.sh
./setup.sh
```

> This auto-installs tools via Homebrew or apt and sets up configs under `~/.config/nvim`.

### 2. Launch Neovim and Sync Plugins

```vim
:Lazy sync
:checkhealth
```

---

## 🧠 Key Shortcuts & Commands

### 🔐 SOPS Encrypted Files

| Key / Command     | Description                                   |
|-------------------|-----------------------------------------------|
| `:SopsEdit <file>`| Decrypt + edit file                           |
| `:SopsVsplit <file>` | Decrypt + open in vertical split           |
| `<leader>se`      | Prompt to SOPS-edit a file                    |
| `<leader>sv`      | Prompt to open a SOPS file in vertical split  |
| `<leader>sy`      | Copy full decrypted buffer to clipboard       |
| `<leader>sp`      | Paste from clipboard into buffer              |

> All changes are **auto re-encrypted** on save using SOPS.

---

### 🗂️ Navigation

| Key / Command        | Action                                 |
|----------------------|----------------------------------------|
| `:NvimTreeToggle`    | Toggle file tree                       |
| `<leader>ff`         | Find files via Telescope               |
| `:split` / `:vsplit` | Horizontal / vertical split            |
| `Ctrl + w + h/j/k/l` | Move between splits                    |
| `gt` / `gT`          | Next / previous tab                    |
| `:tabnew`            | Open new tab                           |
| `:tabclose`          | Close current tab                      |

---

### 🧰 Utilities

| Command       | Description                     |
|---------------|---------------------------------|
| `:checkhealth`| Check Neovim health             |
| `:Lazy sync`  | Sync and install all plugins    |
| `:Telescope keymaps` | Browse all keybindings   |

---

## 🧼 Cleanup

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
```

---

## 📜 License

MIT License

