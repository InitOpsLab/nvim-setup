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
- **Code Linting** - Async linting via nvim-lint (shellcheck, hadolint, tflint, yamllint, ruff, golangci-lint, rubocop)
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
- **claude** CLI (optional, for AI assistance via Sidekick)

### CLI Tools

The setup script will install these automatically, or you can install manually:

| Tool | macOS (brew) | Ubuntu (apt) | Notes |
|------|--------------|--------------|-------|
| `jq`, `yq` | `brew install jq yq` | `sudo apt install jq yq` | JSON/YAML processors |
| `fzf`, `fd` | `brew install fzf fd` | `sudo apt install fzf fd-find` | Fuzzy finder and file search |
| `ripgrep` | `brew install ripgrep` | `sudo apt install ripgrep` | Fast text search |
| `gh` | `brew install gh` | Follow [GitHub CLI install](https://cli.github.com/) | GitHub CLI |
| `bat`, `eza` | `brew install bat eza` | `sudo apt install bat eza` | Better cat/ls alternatives |
| `terraform` | `brew install terraform` | `sudo apt install terraform` | Infrastructure as code |
| `lua-language-server` | `brew install lua-language-server` | Auto-installed via GitHub release | Lua LSP server |

**Note:** The setup script includes prerequisite checks and will verify required tools (git, tar, curl, wget) are available before proceeding.

### Linters (for nvim-lint)

Linters run automatically on file open, save, and leaving insert mode. Install the ones you need:

| Linter | Filetype | Install |
|--------|----------|---------|
| `shellcheck` | bash/sh | `brew install shellcheck` or `sudo apt install shellcheck` |
| `hadolint` | dockerfile | `brew install hadolint` |
| `tflint` | terraform/hcl | `brew install tflint` |
| `yamllint` | yaml | `pip install yamllint` |
| `ruff` | python | `pip install ruff` |
| `golangci-lint` | go | `brew install golangci-lint` |
| `rubocop` | ruby | `gem install rubocop` |

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

### Licensed Plugins (opt-in)

Some plugins require a paid license or subscription and are **disabled by default**. The setup script will prompt you to enable them during installation. You can also toggle them later by editing `~/.config/nvim/lua/config/licensed.lua`:

| Plugin | Requires | Flag |
|--------|----------|------|
| **GitHub Copilot** | GitHub Copilot subscription | `copilot = true` |
| **Sidekick.nvim** | Anthropic subscription (Claude CLI) | `sidekick = true` |

After changing flags, restart Neovim and run `:Lazy sync`.

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
- Check for required prerequisites (git, brew/apt, curl, etc.)
- Install required dependencies (unless `--skip-deps` is used)
- Set up Lazy.nvim plugin manager (unless `--skip-lazy` is used)
- Prompt for licensed plugin preferences (Copilot, Sidekick)
- Copy configuration files to `~/.config/nvim/` (with backup by default)
- Auto-sync plugins (unless `--skip-sync` is used)

### Setup Script Options

The setup script supports several command-line flags for flexible installation:

```bash
# Show help
./setup_nvim.sh --help

# Full installation (default)
./setup_nvim.sh

# Skip dependency installation (if already installed)
./setup_nvim.sh --skip-deps

# Skip lazy.nvim installation
./setup_nvim.sh --skip-lazy

# Skip plugin sync (faster, sync manually later)
./setup_nvim.sh --skip-sync

# Don't backup existing config (clean install)
./setup_nvim.sh --no-backup

# Combine multiple flags
./setup_nvim.sh --skip-deps --skip-sync
```

**Available Flags:**
- `--skip-deps` - Skip installing system dependencies (brew/apt packages)
- `--skip-lazy` - Skip lazy.nvim plugin manager installation
- `--skip-sync` - Skip Lazy plugin sync after config installation
- `--no-backup` - Don't backup existing `~/.config/nvim` directory
- `-h, --help` - Show usage information

3. Launch Neovim and sync plugins (if skipped during setup):

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
| `<C-.>` | n/i/v/t | Toggle Claude (global) |
| `<leader>mm` | n | Toggle Claude |
| `<leader>mc` | n | Restart Claude (fresh project dirs) |
| `<leader>ms` | n | Select AI tool |
| `<leader>mt` | n/v | Send context around cursor |
| `<leader>mf` | n | Send current file |
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
    │   ├── licensed.lua     # Licensed plugin toggles (Copilot, Sidekick)
    │   ├── roots.lua        # Shared project-root marker patterns
    │   ├── lint.lua         # Linter configurations (nvim-lint)
    │   ├── conform.lua      # Formatter configurations
    │   ├── cmp.lua          # Completion setup (nvim-cmp)
    │   ├── dap.lua          # Debug adapter setup
    │   ├── gitsigns.lua     # Git gutter signs & keymaps
    │   ├── neogit.lua       # Git TUI integration
    │   ├── nvim-tree.lua    # File explorer with content filtering
    │   ├── copilot.lua      # GitHub Copilot
    │   ├── sidekick.lua     # Claude AI CLI
    │   ├── sops.lua         # SOPS encryption helpers
    │   └── ...              # Other plugin configs
    └── lazy-plugins/        # Lazy.nvim setup
        └── plugins/         # Plugin declarations
            ├── lsp.lua      # LSP & Mason plugins
            ├── ui.lua       # UI plugins (theme, statusline, etc.)
            ├── tools.lua    # Utility plugins
            ├── ai.lua       # AI plugins (Sidekick, refactoring, aerial)
            ├── dev.lua      # Development plugins (DAP, cmp, Copilot, lint)
            ├── go.lua       # Go-specific plugins
            ├── tasks.lua    # Orgmode, Neorg, Telekasten
            └── testing.lua  # Neotest (Go, Python, Jest, RSpec)
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
- All the amazing plugin authors in the Neovim community
