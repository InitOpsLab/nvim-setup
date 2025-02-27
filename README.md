# Neovim Configuration

This repository contains a Neovim configuration optimized for modern development, featuring:

- **Language Server Protocol (LSP) support** via `mason.nvim`
- **Autocomplete** with `nvim-cmp`
- **Syntax highlighting** with `nvim-treesitter`
- **Markdown & Mermaid preview**
- **Support for various languages and tools**, including YAML, Python, Bash, Terraform, Terragrunt, Docker, AWS CLI, and Kubernetes

---

## 🚀 Features

- **Plugin management** with `packer.nvim`
- **Tree-sitter** for syntax highlighting (supports YAML, Python, Bash, Terraform, Docker, and more)
- **LSP support** via `mason.nvim` and `nvim-lspconfig`
- **Code formatting** using `null-ls.nvim` and `conform.nvim`
- **Keybindings for productivity** (e.g., Markdown preview and file formatting)

---

## 🛠 Installation

### 1️⃣ Install Neovim
Ensure you have **Neovim (0.5+)** installed.

### 2️⃣ Install Packer (Plugin Manager)
```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim \  
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### 3️⃣ Clone this configuration
```sh
git clone <this-repo-url> ~/.config/nvim
```

### 4️⃣ Start Neovim and Install Plugins
```sh
nvim +PackerSync
```

---

## 📦 Plugins Included

| Plugin | Description |
|--------|-------------|
| `packer.nvim` | Plugin manager |
| `nvim-treesitter` | Syntax highlighting |
| `mason.nvim` | LSP manager |
| `mason-lspconfig.nvim` | Easy LSP setup |
| `nvim-lspconfig` | LSP configurations |
| `null-ls.nvim` | Linting & formatting |
| `nvim-cmp` | Auto-completion |
| `LuaSnip` | Snippet support |
| `nvim-lualine` | Status line |
| `bufferline.nvim` | Buffer management |
| `telescope.nvim` | Fuzzy finding |
| `markdown-preview.nvim` | Live Markdown preview |
| `vim-illuminate` | Highlight word under cursor |
| `targets.vim` | Additional text objects |

---

## 🌍 Supported Languages & Tools

- **YAML, Python, Bash, Terraform, Terragrunt, Docker, AWS CLI, Kubernetes**
- **Tree-sitter** ensures syntax support
- **LSP** provides linting & autocomplete

---

## ⚙️ Keybindings

| Keybinding | Action |
|------------|--------|
| `<leader>mp` | Start Markdown preview |
| `<leader>f` | Format the current file |
| `]a / [a` | Move between function parameters |
| `]c / [c` | Move between classes |
| `]d / [d` | Move between functions |

---

## 🎨 UI Enhancements

- **Color scheme:** `catppuccin.nvim`
- **Icons & Status Bar:** `lualine.nvim` and `nvim-web-devicons`
- **Indent Guides:** `mini.indentscope`

---

## 🛠 Troubleshooting

Run the following command inside Neovim to check for errors:
```sh
:checkhealth
```

If plugins don’t load properly, try manually installing them:
```sh
nvim +PackerSync
```

---

## 📜 License

MIT License.

---

## 🤝 Contributing

Feel free to submit **issues** or **PRs** to improve this configuration! 🚀

