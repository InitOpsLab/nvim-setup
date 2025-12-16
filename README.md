# 🛠️ Terminal Dev Environment (Neovim + Lazy + Zsh)

A **fast, modular, and developer-friendly terminal setup** optimized for software engineers and DevSecOps. This configuration transforms Neovim into a full-featured IDE with modern tooling, AI assistance, and comprehensive language support.

![Demo](./assets/demo.gif)

---

## ✨ Features

### Core Capabilities

- **Language Server Protocol (LSP)** - Full IDE features for Go, Python, YAML, JSON, Bash, Terraform, Ruby, TypeScript, Lua, Helm, and more
- **Treesitter** - Advanced syntax highlighting, code folding, and indentation
- **Intelligent Completion** - Auto-completion via `nvim-cmp` with Copilot and snippets via `LuaSnip`
- **Code Formatting** - Automatic format-on-save via Conform.nvim
- **Git Integration** - Status signs in gutter with gitsigns

### AI & Productivity

- **GitHub Copilot** - AI-powered code completion integrated with nvim-cmp
- **Sidekick.nvim** - Claude AI CLI integration for code assistance
- **Refactoring Tools** - Visual refactoring support with ThePrimeagen/refactoring.nvim
- **Symbol Outline** - Code structure navigation with Aerial.nvim

### Debugging & Development

- **Debug Adapter Protocol (DAP)** - Full debugging support with UI for multiple languages
- **Go.nvim** - Enhanced Go development with `:GoRun`, `:GoTest`, `:GoFillStruct`
- **File Navigation** - Fast file switching with Harpoon, fuzzy finder with Telescope, file tree with nvim-tree

### Additional Tools

- **Kubernetes Support** - Cluster interaction (logs, exec, describe, port-forward) with safety features
- **Markdown Preview** - Live preview with Mermaid diagram support
- **Terminal Integration** - Integrated terminal toggling with toggleterm (`<C-\>`)
- **Task Management** - Orgmode, Neorg, and Telekasten support for notes and tasks
- **SOPS Support** - Encryption support for sensitive configuration files
- **Commenting** - Smart commenting with Comment.nvim (`gcc`, `gc`)
- **Which-Key** - Interactive key mapping discovery
- **Catppuccin Theme** - Modern, beautiful color scheme

---

## ✅ Requirements

### System Requirements

- **Neovim** 0.9+ (recommended: 0.11+ for modern LSP API)
- **Git**
- **Node.js** and npm
- **Python** 3.x
- **Go** (optional, for Go development)
- **kubectl** (optional, for Kubernetes development)
- **claude** CLI (optional, for AI assistance via Sidekick)

### CLI Tools

The setup script will install these, or you can install manually:

| Tool | macOS (brew) | Ubuntu (apt) |
|------|--------------|--------------|
| `jq`, `yq` | `brew install jq yq` | `sudo apt install jq yq` |
| `fzf`, `fd` | `brew install fzf fd` | `sudo apt install fzf fd-find` |
| `ripgrep` | `brew install ripgrep` | `sudo apt install ripgrep` |
| `gh` | `brew install gh` | Follow [GitHub CLI install](https://cli.github.com/) |
| `bat`, `eza` | `brew install bat eza` | `sudo apt install bat eza` |
| `terraform` | `brew install terraform` | `sudo apt install terraform` |
| `kubectl` | `brew install kubectl` | `sudo apt install kubectl` |
| `lua-language-server` | `brew install lua-language-server` | `sudo apt install lua-language-server` |

### Formatters (for Conform.nvim)

| Formatter | Install |
|-----------|---------|
| `stylua` | `cargo install stylua` or `brew install stylua` |
| `black` | `pip install black` |
| `prettier` | `npm install -g prettier` |
| `shfmt` | `brew install shfmt` |
| `gofumpt` | `go install mvdan.cc/gofumpt@latest` |
| `goimports` | `go install golang.org/x/tools/cmd/goimports@latest` |
| `golines` | `go install github.com/segmentio/golines@latest` |
| `rubocop` | `gem install rubocop` |
| `sqlfmt` | `pip install shandy-sqlfmt` |

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

> **Tip:** Press `<leader>` (Space) and wait to see available key mappings via which-key.

### Key Commands

#### Core Editor

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>` | n | Space (default leader key) |
| `<Esc>` | n | Clear search highlight |
| `<leader>w` | n | Save file |
| `<leader>q` | n | Quit |
| `<C-h/j/k/l>` | n | Window navigation |
| `<C-Up/Down/Left/Right>` | n | Resize windows |
| `<S-h>` / `<S-l>` | n | Previous/Next buffer |
| `<leader>bd` | n | Delete buffer |
| `<C-d>` / `<C-u>` | n | Scroll down/up (centered) |
| `J` / `K` | v | Move lines down/up |
| `<` / `>` | v | Indent left/right (stays in visual) |
| `gcc` | n | Toggle line comment |
| `gc` | v | Toggle comment on selection |

#### File Navigation (Telescope & Harpoon)

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Browse buffers |
| `<leader>fh` | Find help tags |
| `<leader>a` | Add file to Harpoon |
| `<C-e>` | Toggle Harpoon quick menu |
| `<leader>1-4` | Navigate to Harpoon file 1-4 |

#### LSP & Code Actions

| Key | Description |
|-----|-------------|
| `K` | Show diagnostics (if any) or hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>oi` | Organize imports |
| `<leader>rr` | Visual refactoring (visual mode) |
| `<leader>o` | Toggle symbol outline (Aerial) |

#### Debugging (DAP)

| Key | Description |
|-----|-------------|
| `<F5>` | Continue/Start debugging |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<S-F11>` | Step out |
| `<leader>du` | Toggle DAP UI |

#### Terminal

| Key | Description |
|-----|-------------|
| `<C-\>` | Toggle terminal (horizontal split) |

#### AI (Sidekick - Claude CLI)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-.>` | n/i/v/t | Toggle AI CLI (global) |
| `<leader>mm` | n | Toggle AI CLI |
| `<leader>mc` | n | Toggle Claude |
| `<leader>ms` | n | Select AI tool |
| `<leader>mt` | n/v | Send context around cursor |
| `<leader>mf` | n | Send current file |
| `<leader>mv` | v | Send visual selection |
| `<leader>mp` | n/v | Prompt picker (explain, fix, tests, etc.) |

#### SOPS (Encrypted Files)

| Key | Description |
|-----|-------------|
| `<leader>se` | Edit encrypted file |
| `<leader>sv` | VSplit encrypted file |
| `<leader>sy` | Copy decrypted buffer to clipboard |
| `<leader>sp` | Paste from clipboard |

#### Go Development

| Key | Description |
|-----|-------------|
| `<leader>gt` | Run Go tests |
| `:GoRun` | Run current file |
| `:GoTest` | Run tests |
| `:GoFillStruct` | Fill struct fields |

#### Kubernetes

| Key/Command | Description |
|-------------|-------------|
| `:Kubectl` | Open Kubernetes cluster interaction menu |
| **Safety** | `create` and `delete` commands are blocked by default |

- View logs, exec into pods, describe resources, port-forward, and more
- YAML schema validation and hover info for Kubernetes resources
- Customize blocked commands in `config/kubernetes.lua`

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
    ├── options.lua          # Editor options & core keymaps
    ├── config/              # Plugin configurations
    │   ├── lsp.lua          # LSP server configurations
    │   ├── dap.lua          # Debug adapter setup
    │   ├── conform.lua      # Formatter configurations
    │   ├── kubernetes.lua   # Kubernetes safety wrapper
    │   ├── sidekick.lua     # Claude AI CLI integration
    │   ├── sops.lua         # SOPS encryption helpers
    │   └── ...              # Other plugin configs
    └── lazy-plugins/        # Lazy.nvim setup
        └── plugins/         # Plugin declarations
            ├── lsp.lua      # LSP & Mason plugins
            ├── ui.lua       # UI plugins (theme, statusline, etc.)
            ├── tools.lua    # Utility plugins
            ├── ai.lua       # AI plugins (Copilot, Sidekick)
            ├── dev.lua      # Development plugins (DAP, cmp)
            ├── go.lua       # Go-specific plugins
            └── kubernetes.lua # Kubernetes plugins
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
- **Formatting**: gofumpt, goimports, golines (format-on-save)
- **Keymap**: `<leader>gt` - Run tests

### Kubernetes Development

The configuration includes comprehensive Kubernetes support:

- **kubectl.nvim** - Interactive cluster management:
  - View pod logs, exec into containers
  - Describe resources, port-forward services
  - Resource tree visualization
  - **Safety**: `create` and `delete` commands are blocked by default
  - Customize blocked commands in `config/kubernetes.lua`
- **kubernetes.nvim** - YAML/CRD support:
  - Schema validation for Kubernetes resources
  - Hover documentation for resource fields
  - Auto-completion for resource types

**Usage:**

- Open Kubernetes menu: `:Kubectl`
- Edit blocked commands: `~/.config/nvim/lua/config/kubernetes.lua`

### Helm Development

- **helm_ls** LSP server for Helm charts and Go templates
- YAML language server integration for values files

### Other Languages

LSP servers are automatically installed via Mason. Configured languages include:

| Language | LSP Server | Formatter |
|----------|------------|-----------|
| Python | pyright | black |
| TypeScript/JavaScript | ts_ls | prettier |
| Ruby | solargraph | rubocop |
| YAML | yamlls | prettier |
| JSON | jsonls | prettier |
| Terraform/HCL | terraformls | terraform_fmt |
| Bash | bashls | shfmt |
| Lua | lua_ls | stylua |
| SQL | sqlls | sqlfmt |
| Markdown | - | prettier |

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
- [Sidekick.nvim](https://github.com/folke/sidekick.nvim) - AI CLI integration
- [kubectl.nvim](https://github.com/Ramilito/kubectl.nvim) - Kubernetes cluster interaction
- All the amazing plugin authors in the Neovim community
