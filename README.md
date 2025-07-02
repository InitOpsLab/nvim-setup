# 🛠️ Terminal Dev Environment (Neovim + Lazy + Zsh)

A fast, modular, and productive terminal environment optimized for developers and DevSecOps engineers.

Includes:

- Neovim + Lazy.nvim plugin manager  
- Treesitter, LSP, Completion, Formatting  
- Zsh with aliases/functions  
- Markdown + Mermaid live preview  
- Tooling for JSON, YAML, HCL, Python, Docker, K8s, Go

---

## ✅ Requirements

| Tool               | macOS Command                        | Ubuntu Command                                    |
|--------------------|--------------------------------------|----------------------------------------------------|
| Neovim             | `brew install neovim`                | `sudo apt install neovim`                          |
| Git                | `brew install git`                   | `sudo apt install git`                             |
| Node.js            | `brew install node`                  | `sudo apt install nodejs npm`                      |
| Python             | `brew install python`                | `sudo apt install python3 python3-pip`             |
| Go                 | `brew install go`                    | `sudo apt install golang-go`                       |
| CLI Tools          | `jq`, `yq`, `fzf`, `fd`, `ripgrep`, `gh`, `bat`, `exa`, `terraform`, `lua-language-server` |
| Markdown & Mermaid | `npm install -g @mermaid-js/mermaid-cli` (for Mermaid diagrams) |

---

## 🚀 Quick Start

```bash
git clone https://github.com/BashBangers/nvim-setup.git
cd nvim-setup
chmod +x setup_nvim.sh
./setup_nvim.sh
```

Then in Neovim:

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

- LSP support for **Go**, Python, YAML, JSON, Bash, Terraform, etc.  
- Treesitter-powered syntax, folding & indent  
- Completion via `nvim-cmp`, snippets via `LuaSnip`  
- `go.nvim` integration: `:GoRun`, `:GoTest`, `:GoFillStruct`, inlay hints  
- Markdown live preview + Mermaid diagram rendering  
- File tree, terminal toggling, fuzzy finder  
- Git integration with status, blame, and diff  
- Harpoon for fast file navigation  
- Autopairs, commenting, and code actions

---

## 🛠️ Go Support

1. **Treesitter**  
   We install and enable Go parsers so you get syntax highlighting, folding, and indent for `.go` and `go.mod` files (see `config/treesitter.lua`).

2. **LSP (`gopls`)**  
   Mason ensures `gopls` is installed, and `lspconfig` wires it up with:
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
   - Declared in `lazy-plugins/plugins/go.lua`  
   - Configured in `config/go.lua` with:
     ```lua
     require("go").setup({
       goimport        = "goimports",
       fillstruct      = "gopls",
       lsp_inlay_hints = { enable = true },
     })
     vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", { silent=true })
     ```

Reload Neovim, open a `.go` file, and you’ll have full Go DX: formatting, code actions, testing, and rich editor support.

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

*(…continued in original README…)*

---

## 📜 License

MIT License
