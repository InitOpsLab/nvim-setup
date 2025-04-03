# 🛠️ Terminal Dev Environment (Neovim + Lazy + Zsh)

A fast, modular, and productive terminal environment optimized for developers and DevSecOps engineers.

Includes:

- Neovim + Lazy.nvim plugin manager
- Treesitter, LSP, Completion, Formatting
- Zsh with aliases/functions
- Markdown + Mermaid live preview
- Tooling for JSON, YAML, HCL, Python, Docker, K8s

---

## ✅ Requirements

| Tool       | macOS Command              | Ubuntu Command                  |
|------------|----------------------------|----------------------------------|
| Neovim     | `brew install neovim`      | `sudo apt install neovim`       |
| Git        | `brew install git`         | `sudo apt install git`          |
| Node.js    | `brew install node`        | `sudo apt install nodejs npm`   |
| Python     | `brew install python`      | `sudo apt install python3 python3-pip` |
| CLI Tools  | `jq`, `yq`, `fzf`, `fd`, `ripgrep`, `gh`, `bat`, `exa`, `terraform`, `lua-language-server` |
| Markdown   | `npm install -g @mermaid-js/mermaid-cli` (for Mermaid diagrams) |

---

## 🚀 Quick Start

```bash
git clone https://github.com/your-user/neovim-lazy-devsetup.git
cd neovim-lazy-devsetup
chmod +x setup.sh
./setup.sh
```

---

## 📁 Folder Structure

```
configs/
├── init.lua
└── lua/
    ├── options.lua
    ├── config/
    │   ├── harpoon.lua
    │   ├── toggleterm.lua
    │   ├── schemastore.lua
    │   └── markdown.lua
    └── lazy-plugins/
        ├── init.lua
        └── plugins/
            ├── lsp.lua
            ├── ui.lua
            ├── tools.lua
            ├── dev.lua
```

---

## 🔌 Key Features

- LSP support for Python, YAML, JSON, Bash, Terraform, etc.
- Autocompletion and formatting
- File tree (nvim-tree), terminal (toggleterm), fuzzy finder (telescope)
- Git integration via gitsigns
- Harpoon quick navigation
- Markdown live preview with Mermaid diagram support
- Comment toggling and autopairing

---

## 🧠 Lazy.nvim Plugin Commands

- `:Lazy` – Open Lazy UI
- `:Lazy sync` – Install/update plugins
- `:Lazy profile` – Show startup performance
- `:Lazy clean` – Remove unused plugins

---

## ⌨️ Keybindings

| Binding       | Action                     |
|---------------|----------------------------|
| `<leader>a`   | Add file to Harpoon        |
| `<C-e>`       | Toggle Harpoon menu        |
| `<leader>1-4` | Jump to Harpoon file       |
| `<C-\>`       | Toggle terminal            |
| `:MarkdownPreview` | Open markdown preview |
| `<leader>f`   | Format current file (LSP)  |

---

## 📝 Markdown & Mermaid Preview

To preview `.md` files:

1. Open a Markdown file in Neovim
2. Run `:MarkdownPreview`
3. A browser window opens with live preview

For Mermaid diagram rendering:

- Install Mermaid CLI:  
  `npm install -g @mermaid-js/mermaid-cli`

Preview is enabled with:

```lua
vim.g.mkdp_preview_options = {
  mermaid = {
    enable = true,
    executable = 'mmdc',
    options = '--theme dark'
  }
}
```

---

## 🧼 Cleanup (Uninstall)

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
```

---

## 🖥 Terminal Recommendation

- iTerm2 (macOS) with “Natural Text Editing” preset
- Kitty / Alacritty with Nerd Fonts

---

## 📜 License

MIT License

