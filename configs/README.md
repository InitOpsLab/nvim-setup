# 🛠️ Terminal Dev Environment (Neovim + Lazy + Zsh)

A **fast, modular, and developer-friendly terminal setup** optimized for software engineers and DevSecOps.  

![Demo](./assets/demo.gif)

This environment turns Neovim into a full IDE with batteries included:

- **Neovim** with [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager  
- **LSP, Treesitter, Completion, Formatting** for multiple languages  
- **Zsh** with handy aliases & functions  
- **Markdown + Mermaid live preview** for docs and diagrams  
- Built-in tooling for JSON, YAML, HCL, Python, Docker, Kubernetes, Go, and more  

---

## ✅ Requirements

| Tool               | macOS (brew)                 | Ubuntu (apt)                                    |
|--------------------|------------------------------|-------------------------------------------------|
| Neovim             | `brew install neovim`        | `sudo apt install neovim`                       |
| Git                | `brew install git`           | `sudo apt install git`                          |
| Node.js            | `brew install node`          | `sudo apt install nodejs npm`                   |
| Python             | `brew install python`        | `sudo apt install python3 python3-pip`          |
| Go                 | `brew install go`            | `sudo apt install golang-go`                    |
| CLI Tools          | `jq`, `yq`, `fzf`, `fd`, `ripgrep`, `gh`, `bat`, `exa`, `terraform`, `lua-language-server` |
| Markdown & Mermaid | `npm install -g @mermaid-js/mermaid-cli` |

---

## 🚀 Quick Start

```bash
git clone https://github.com/BashBangers/nvim-setup.git
cd nvim-setup
chmod +x setup_nvim.sh
./setup_nvim.sh
```

Then inside Neovim:

```vim
:Lazy sync
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
    │   ├── treesitter.lua
    │   ├── lsp.lua
    │   └── go.lua             ← Go-specific settings
    └── lazy-plugins/
        ├── init.lua
        └── plugins/
            ├── lsp.lua
            ├── ui.lua
            ├── tools.lua
            ├── dev.lua
            └── go.lua         ← go.nvim declaration
```

---

## 🔌 Plugin Features

- **LSP** for Go, Python, YAML, JSON, Bash, Terraform, and more  
- **Treesitter** for syntax, folding, and indent  
- **Completion** via `nvim-cmp`, snippets via `LuaSnip`  
- **Go.nvim** integration: `:GoRun`, `:GoTest`, `:GoFillStruct`, inlay hints  
- **Markdown live preview** with Mermaid diagrams  
- **File tree, terminal toggling, fuzzy finder** with Telescope  
- **Git tools**: status, blame, diffs with gitsigns + fugitive  
- **Harpoon** for fast file navigation  
- **Autopairs, commenting, and code actions**

---

## 🛠️ Go Support

1. **Treesitter**  
   Go parsers enabled for `.go` and `go.mod` files.

2. **LSP (`gopls`)**  
   Managed via Mason + LSPConfig:
   ```lua
   require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })
   require("lspconfig").gopls.setup({
     settings = {
       gopls = {
         analyses    = { unusedparams = true, shadow = true },
         staticcheck = true,
       },
     },
   })
   ```

3. **`go.nvim` Plugin**  
   Declared in `lazy-plugins/plugins/go.lua`  
   Configured in `config/go.lua`:
   ```lua
   require("go").setup({
     goimport        = "goimports",
     fillstruct      = "gopls",
     lsp_inlay_hints = { enable = true },
   })
   vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", { silent=true })
   ```

Reload Neovim, open a `.go` file, and enjoy full Go DX: formatting, code actions, tests, and inlay hints.

---

## 🧠 Neovim Cheat Sheet (Modern DevSecOps Setup)

### 📌 Basic Navigation

| Key | Action |
| --- | --- |
| `h/j/k/l` | Move left/down/up/right |
| `gg` / `G` | Go to start / end of file |
| `0` / `^` / `$` | Start / first non-blank / end of line |
| `Ctrl+u / Ctrl+d` | Half-page up/down |
| `Ctrl+b / Ctrl+f` | Full-page up/down |
| `w/W`, `e/E`, `b/B`, `ge/gE` | Word motions |

*(…extend as needed for your workflow…)*

---

## 📜 License

MIT License
