# 🛠️ Terminal Dev Environment (Neovim + Lazy + Zsh)

A **fast, modular, and developer-friendly terminal setup** optimized for software engineers and DevSecOps. This configuration transforms Neovim into a full-featured IDE with modern tooling, AI assistance, and comprehensive language support.

![Demo](./assets/demo.gif)

---

## ✨ Features

### Core Capabilities

- **Language Server Protocol (LSP)** - Full IDE features for Go, Python, YAML, JSON, Bash, Terraform, Ruby, and more
- **Treesitter** - Advanced syntax highlighting, code folding, and indentation
- **Intelligent Completion** - Auto-completion via `nvim-cmp` with snippets via `LuaSnip`
- **Code Formatting** - Automatic formatting via Conform.nvim
- **Git Integration** - Status, blame, diffs with gitsigns and fugitive

### AI & Productivity

- **GitHub Copilot** - AI-powered code suggestions
- **Refactoring Tools** - Visual refactoring support with ThePrimeagen/refactoring.nvim
- **Symbol Outline** - Code structure navigation with Aerial.nvim

### Debugging & Development

- **Debug Adapter Protocol (DAP)** - Full debugging support with UI for multiple languages
- **Go.nvim** - Enhanced Go development with `:GoRun`, `:GoTest`, `:GoFillStruct`, and inlay hints
- **File Navigation** - Fast file switching with Harpoon, fuzzy finder with Telescope, file tree with nvim-tree

### Additional Tools

- **Markdown Preview** - Live preview with Mermaid diagram support
- **Terminal Integration** - Integrated terminal toggling
- **Task Management** - Orgmode/Neorg support for notes and tasks
- **SOPS Support** - Encryption support for sensitive configuration files
- **Project Management** - Automatic project root detection

---

## ✅ Requirements

### System Requirements

- **Neovim** 0.9+ (recommended: latest stable)
- **Git**
- **Node.js** and npm
- **Python** 3.x
- **Go** (optional, for Go development)

### CLI Tools

The setup script will install these, or you can install manually:

| Tool | macOS (brew) | Ubuntu (apt) |
|------|--------------|--------------|
| `jq`, `yq` | `brew install jq yq` | `sudo apt install jq yq` |
| `fzf`, `fd` | `brew install fzf fd` | `sudo apt install fzf fd-find` |
| `ripgrep` | `brew install ripgrep` | `sudo apt install ripgrep` |
| `gh` | `brew install gh` | Follow [GitHub CLI install](https://cli.github.com/) |
| `bat`, `exa` | `brew install bat eza` | `sudo apt install bat eza` |
| `terraform` | `brew install terraform` | `sudo apt install terraform` |
| `lua-language-server` | `brew install lua-language-server` | `sudo apt install lua-language-server` |

### NPM Packages

```bash
npm install -g @mermaid-js/mermaid-cli yaml-language-server vscode-langservers-extracted
```

---

## 🚀 Installation

### Quick Start

1. Clone the repository:

```bash
git clone https://github.com/BashBangers/nvim-setup.git
cd nvim-setup
```

2. Run the setup script:

```bash
chmod +x setup_nvim.sh
./setup_nvim.sh
```

The script will:

- Detect your OS (macOS or Ubuntu)
- Install required dependencies
- Set up Lazy.nvim plugin manager
- Copy configuration files to `~/.config/nvim/`
- Auto-sync plugins

3. Launch Neovim and sync plugins:

```vim
:Lazy sync
```

### Manual Installation

If you prefer manual setup:

1. Copy the configuration:

```bash
mkdir -p ~/.config/nvim
cp -r configs/* ~/.config/nvim/
```

2. Install Lazy.nvim:

```bash
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
```

3. Launch Neovim and run `:Lazy sync`

---

## 🎯 Usage

### Key Commands

#### Navigation

- `<leader>` - Space (default leader key)
- `<leader>ff` - Find files with Telescope
- `<leader>fg` - Search in files
- `<leader>fb` - Browse buffers
- `<leader>gt` - Run Go tests (Go files)

#### Git

- `:Git` or `:Gstatus` - Git status (fugitive)
- `:Gdiff` - View diffs
- `:Gblame` - View blame
- View diffs and blame directly in Neovim

#### Code Actions

- `K` - Hover documentation
- `gd` - Go to definition
- `gr` - References
- `<leader>ca` - Code actions
- `<leader>rr` - Visual refactoring (visual mode)

#### Debugging

- DAP commands available when debuggers are configured
- Check `config/dap.lua` and `config/dap-langs.lua` for setup

### Configuration

Configuration files are organized in `~/.config/nvim/lua/`:

- `config/` - Plugin configurations
- `lazy-plugins/plugins/` - Plugin declarations
- `options.lua` - Editor options

Customize by editing files in `~/.config/nvim/lua/config/`.

---

## 📁 Project Structure

```text
configs/
├── init.lua                 # Entry point
└── lua/
    ├── options.lua          # Editor options
    ├── config/              # Plugin configurations
    └── lazy-plugins/        # Lazy.nvim setup
        └── plugins/         # Plugin declarations
```

Each language/tool has its own configuration file in `config/` for easy customization.

---

## 🛠️ Language-Specific Setup

### Go Development

The configuration includes full Go support:

- **Treesitter** parsers for `.go` and `go.mod`
- **gopls** LSP server (auto-installed via Mason)
- **go.nvim** plugin with commands:
  - `:GoRun` - Run current file
  - `:GoTest` - Run tests
  - `:GoFillStruct` - Fill struct fields
  - Inlay hints enabled

### Other Languages

LSP servers are automatically installed via Mason when you open a file type. Configured languages include:

- Python, Ruby, JavaScript/TypeScript
- YAML, JSON, Terraform (HCL)
- Bash, Lua, and more

Add new language servers by editing `lua/lazy-plugins/plugins/lsp.lua`.

---

## 🐛 Troubleshooting

### Plugins not loading

- Run `:Lazy sync` to ensure all plugins are installed
- Check `:Lazy health` for plugin status
- Restart Neovim after configuration changes

### LSP not working

- Ensure language servers are installed: `:Mason`
- Check `:LspInfo` to see active LSP servers
- Verify the language server is in your PATH

### Performance issues

- Reduce plugins in `lazy-plugins/plugins/` if not needed
- Check `:Lazy profile` for slow-loading plugins
- Disable unused language servers

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Acknowledgments

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [Neovim](https://neovim.io/) - Hyperextensible Vim-based text editor
- All the amazing plugin authors in the Neovim community
