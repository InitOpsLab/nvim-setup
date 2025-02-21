# Neovim Setup Script

This script automates the installation and configuration of **Neovim** on **macOS** and **Ubuntu**. It installs dependencies, sets up plugin managers, and configures Neovim with an enhanced **Lua-based setup**, including LSPs, auto-completion, Treesitter, Git integration, and UI improvements.

---

## 🚀 Features

- **Auto-detects OS** (macOS or Ubuntu)
- **Installs required dependencies** (Neovim, LSPs, utilities, and more)
- **Copies Neovim configurations** (`vimrc` and `init.lua`)
- **Installs and sets up Packer.nvim** for plugin management
- **Enables Treesitter** for syntax highlighting and code navigation
- **Configures LSP, auto-completion (nvim-cmp), and snippet support (LuaSnip)**
- **Improves UI** with bufferline.nvim, heirline.nvim, and catppuccin/nvim
- **Integrates Git functionality** with vim-fugitive and gitsigns.nvim
- **Adds utilities** for indentation, text objects, formatting, and more

---

## 📂 Directory Structure

```
nvim-setup/
│── configs/              # Configuration files for Neovim
│   ├── vimrc             # Neovim legacy Vim configuration
│   ├── init.lua          # Main Neovim Lua configuration
│── setup_nvim.sh         # Installation script
│── README.md             # Documentation (this file)
```

---

## 💾 Installation

### 1️⃣ Clone this repository

```sh
git clone https://github.com/irussak/nvim-setup.git
cd nvim-setup
```

### 2️⃣ Run the setup script

```sh
chmod +x setup_nvim.sh
./setup_nvim.sh
```

---

## 🛠️ What the Script Does

- Detects the OS (**macOS** or **Ubuntu**)
- Installs required packages (Neovim, LSPs, Git, Node.js, Python, etc.)
- Copies configuration files from `configs/` to `~/.vimrc` and `~/.config/nvim/init.lua`
- Installs **Packer.nvim** (if not installed)
- Installs Neovim plugins and configures them for optimal performance

---

## 🔧 Post Installation Steps

Once the setup is complete:

1️⃣ Open Neovim:

```sh
nvim
```

2️⃣ Install plugins:

```vim
:PackerSync
```

3️⃣ Install Treesitter parsers inside Neovim:

```vim
:TSUpdate
```

---

## 📦 Installed Dependencies

### 🔹 macOS (Homebrew)

```sh
brew install neovim git python node ripgrep fzf fd jq terraform lua-language-server
```

### 🔹 Ubuntu (APT)

```sh
sudo apt install neovim git python3 nodejs npm ripgrep fzf fd-find jq terraform lua-language-server
```

---

## 📜 Included Plugins & Features

### 🌿 Syntax & Code Navigation
- **Treesitter** (nvim-treesitter) - Syntax highlighting and better code navigation
- **Text Objects** (nvim-treesitter-textobjects) - Enhanced text object selection

### ⚡ LSP & Completion
- **LSP Support** (nvim-lspconfig, mason.nvim) - Language server integration
- **Auto-completion** (nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline)
- **Snippets** (LuaSnip) - Expandable snippets

### 📌 Git Integration
- **Git support** (vim-fugitive, gitsigns.nvim) - View diffs, commits, and more

### 🎨 UI Enhancements
- **Status line** (heirline.nvim)
- **Tabline / Buffers** (bufferline.nvim)
- **Theme** (catppuccin/nvim) - Beautiful color scheme

### 🔍 Fuzzy Finder
- **Telescope.nvim** - Fast fuzzy finding for files, symbols, and more

### 📝 Formatting & Indentation
- **Conform.nvim** - Auto-format files on save
- **Mini Indentscope** - Shows indentation levels visually

### 📌 Extra Utilities
- **vim-illuminate** - Highlights word under cursor
- **vim-sort-motion** - Sorts selected text
- **CamelCaseMotion** - Navigate within camel-case words
- **targets.vim** - Additional text objects for editing

---

## 📜 Troubleshooting

### 🔹 Permission Issues

If you encounter permission errors, run:

```sh
chmod +x setup_nvim.sh
sudo ./setup_nvim.sh
```

### 🔹 Neovim Not Found

If Neovim doesn’t launch after installation, restart your terminal or run:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

---

## 📌 Contributing

Feel free to open an **issue** or **pull request** if you have improvements or bug fixes.

---

## 📜 License

This script is open-source and available under the **MIT License**.

---

🎯 **Your Neovim is now fully configured and ready to use! 🚀**

