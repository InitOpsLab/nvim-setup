# ⚡ Neovim Configuration (DevSecOps Ready)

A **modern, fast, and productive Neovim setup** tailored for development and DevSecOps workflows.

---

## ✨ Highlights

- 🌐 **LSP** support via `mason.nvim`
- 🧠 Autocompletion with `nvim-cmp`
- 🌈 Syntax highlighting powered by Tree-sitter
- 📄 Markdown & Mermaid live preview
- 🛠 Supports YAML, Python, Bash, Terraform, Docker, Kubernetes, SQL, JSON, HCL, and more
- 🚀 Lazy-loaded plugins with `lazy.nvim` for speed and performance

---

## 🚀 Features

- 📦 Plugin management using `lazy.nvim`
- 🌍 LSP integration via `mason.nvim` and `nvim-lspconfig`
- 🧱 Code formatting with `conform.nvim` and `null-ls.nvim`
- 🔎 Fuzzy finding powered by `telescope.nvim`
- 🗂 File explorer, terminal toggler, Harpoon bookmarks
- 🎯 Productivity tools: TODOs, smart motions, UI polish

---

## 🛠 Installation

### 1️⃣ Prerequisites

#### macOS

```bash
brew install neovim git python node ripgrep fzf fd jq terraform lua-language-server
```

#### Ubuntu

```bash
sudo apt update
sudo apt install neovim git python3 python3-pip nodejs npm ripgrep fzf fd-find jq terraform lua-language-server
```

### 2️⃣ Clone This Configuration

```bash
git clone <this-repo-url> ~/nvim-setup
cd ~/nvim-setup
./setup.sh
```

This script:
- Installs `lazy.nvim`
- Sets up config in `~/.config/nvim/`
- Ensures all required tools are installed

### 3️⃣ Launch Neovim & Install Plugins

```bash
nvim
```

Then inside Neovim, run:

```vim
:Lazy sync
```

---

## 📦 Plugin Overview

| Plugin | Purpose |
|--------|---------|
| `lazy.nvim` | Plugin manager |
| `nvim-treesitter` | Syntax highlighting |
| `mason.nvim` + `lspconfig` | LSP setup |
| `nvim-cmp` + `LuaSnip` | Autocompletion & snippets |
| `null-ls.nvim` + `conform.nvim` | Formatters & linters |
| `nvim-tree.lua` | File explorer |
| `toggleterm.nvim` | Integrated terminal |
| `harpoon` | Quick file navigation/bookmarking |
| `telescope.nvim` | Fuzzy finder |
| `markdown-preview.nvim` | Markdown + Mermaid live preview |
| `todo-comments.nvim` | Highlight TODO/FIXME/etc |
| `indent-blankline.nvim` | Indentation guides |
| `spectre.nvim` | Project-wide search & replace |
| `noice.nvim`, `notify.nvim` | Enhanced UI for messages |
| `which-key.nvim` | Keybinding hints |
| `lualine.nvim`, `bufferline.nvim` | Statusline & buffer line |

---

## 🧠 Supported Languages

| Language | LSP | Formatter |
|---------|-----|-----------|
| Python | `pyright` | `black` |
| JSON | `jsonls` | `prettier` |
| YAML | `yamlls` | `prettier` |
| Bash | `bashls` | `shfmt` |
| Terraform/HCL | `terraformls` | `terraform_fmt` |
| SQL | `sqlls` | `sqlfmt`, `sqlparse` |
| Lua | `lua_ls` | Built-in |
| Docker | `dockerls` | — |
| Markdown | — | Preview only |

---

## 🎯 Keybindings

| Keybinding | Action |
|------------|--------|
| `<leader>f` | Format current buffer |
| `<leader>e` | Toggle file explorer |
| `<leader>t` | Toggle terminal |
| `<leader>mp` | Markdown preview |
| `<leader>ff` | Find file (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>td` | List TODOs |
| `<leader>ha` | Add Harpoon bookmark |
| `<leader>hh` | Show Harpoon UI |
| `<leader>hn` | Harpoon next file |
| `<leader>hp` | Harpoon previous file |
| `<leader>S` | Open Spectre |
| `<leader>nl` | Show message log (Noice) |

---

## 🎨 UI & Theme

- 🌈 **Colorscheme**: `catppuccin`
- 📊 **Status Line**: `lualine`
- 📂 **Icons**: `nvim-web-devicons`
- ⌨️ **Key help**: `which-key`
- 🔔 **Notifications**: `notify`, `noice`

---

## ✅ Troubleshooting

Run diagnostics inside Neovim:

```vim
:checkhealth
```

To reinstall or sync plugins:

```vim
:Lazy sync
```

---

## 📜 License

MIT License

---

## 🤝 Contributing

Contributions, bug reports, and PRs are welcome. Feel free to fork, tweak, and share improvements 🚀

**Happy hacking! 💻⚡**  
_Made with ❤️ using Neovim_
ownloadable starter repo!
