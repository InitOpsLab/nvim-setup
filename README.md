# Terminal Dev Environment Setup (Neovim + Lazy + Zsh)

A modular, fast, and productive development environment powered by:

- Neovim + Lazy.nvim
- Zsh (with zinit or Oh-My-Zsh)
- LSP, Treesitter, Autocompletion
- DevSecOps tooling: YAML, HCL, JSON, Docker, K8s, Python, etc.

---

## Requirements

| Tool       | macOS                     | Ubuntu                        |
|------------|---------------------------|-------------------------------|
| Neovim     | `brew install neovim`     | `sudo apt install neovim`     |
| Git        | `brew install git`        | `sudo apt install git`        |
| Node.js    | `brew install node`       | `sudo apt install nodejs npm` |
| Python     | `brew install python`     | `sudo apt install python3 python3-pip` |
| Extras     | `jq`, `yq`, `ripgrep`, `fzf`, `fd`, `terraform`, `lua-language-server`, `bat`, `exa`, `gh`

---

## Quick Start

```bash
git clone https://github.com/your-user/neovim-lazy-devsetup.git
cd neovim-lazy-devsetup
chmod +x setup.sh
./setup.sh
```

This will:
- Detect your OS
- Install missing dependencies
- Clone and configure Lazy.nvim
- Copy over your custom Neovim configuration

---

## Project Structure

```
configs/
├── init.lua              # Main Neovim entry
└── lua/
    ├── options.lua       # Editor settings
    ├── config/           # Plugin configurations
    │   ├── harpoon.lua
    │   ├── toggleterm.lua
    │   └── schemastore.lua
    └── lazy-plugins/     # Lazy plugin definitions
        ├── init.lua
        └── plugins/
            ├── lsp.lua
            ├── ui.lua
            ├── tools.lua
            ├── dev.lua
```

---

## Lazy Plugin Manager

To manage plugins inside Neovim:

- `:Lazy` – open plugin UI
- `:Lazy sync` – sync changes
- `:Lazy clean` – remove unused
- `:Lazy profile` – view startup time

---

## Features

- LSP support via mason.nvim
- Treesitter-powered syntax highlighting & folding
- Formatter with conform.nvim
- File explorer: nvim-tree
- Harpoon file nav
- Toggle terminal with toggleterm
- Schema autocomplete for JSON/YAML
- Fuzzy file search: telescope
- Git integration: gitsigns.nvim

---

## Key Mappings

| Keybinding    | Action                  |
|---------------|-------------------------|
| `<leader>a`   | Add file to Harpoon     |
| `<C-e>`       | Toggle Harpoon menu     |
| `<leader>1`   | Jump to Harpoon file 1  |
| `<C-\>`       | Toggle terminal         |

---

## Health Check

```bash
nvim --version | grep clipboard
```

Output should show: `+clipboard`

Run `:checkhealth` inside Neovim to verify LSP, Treesitter, etc.

---

## Uninstall

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
```

---

## Terminal Recommendation

- iTerm2 with "Natural Text Editing" preset
- Kitty or Alacritty with Nerd Fonts installed

---

## License

MIT License

