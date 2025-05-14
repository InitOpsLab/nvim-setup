# 🛠️ Terminal Dev Environment (Neovim + Lazy)

A fast, modular, and productive Neovim environment optimized for developers and DevSecOps engineers.

Includes:

- Neovim + Lazy.nvim plugin manager
- Treesitter, LSP, Completion, Formatting
- GitHub Copilot, Refactoring, Symbol Outline
- Markdown + Mermaid preview
- Notes + Task Management (orgmode, neorg, telekasten)

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
    │   ├── markdown.lua
    │   └── tasks.lua
    └── lazy-plugins/
        ├── init.lua
        └── plugins/
            ├── lsp.lua
            ├── ui.lua
            ├── tools.lua
            ├── dev.lua
            ├── tasks.lua
```

---

## 🔌 Plugin Features (Updated)

- LSP support for Python, YAML, JSON, Bash, Terraform, etc.
- Treesitter-powered syntax + folding
- Completion via `nvim-cmp`, snippets via `LuaSnip`
- **GitHub Copilot with inline AI suggestions**
- **Visual code refactoring with `refactoring.nvim`**
- **Symbol outline view with `aerial.nvim`**
- **Markdown live preview + Mermaid support**
- **Task & Notes system: `orgmode`, `neorg`, `telekasten`**
- Git integration, fuzzy finding, file tree, terminals
- Harpoon for fast file jumping, code navigation helpers

---

## 🧠 Neovim Cheat Sheet (Modern DevSecOps Setup)

<full cheat sheet remains unchanged>

