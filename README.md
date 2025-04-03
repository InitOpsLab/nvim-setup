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

Includes YAML LSP support via [`yaml-language-server`](https://github.com/redhat-developer/yaml-language-server).

| Tool       | macOS Command              | Ubuntu Command                  |
|------------|----------------------------|----------------------------------|
| Neovim     | `brew install neovim`      | `sudo apt install neovim`       |
| Git        | `brew install git`         | `sudo apt install git`          |
| Node.js    | `brew install node`        | `sudo apt install nodejs npm`   |
| Python     | `brew install python`      | `sudo apt install python3 python3-pip` |
| CLI Tools  | `jq`, `yq`, `fzf`, `fd`, `ripgrep`, `gh`, `bat`, `exa`, `terraform`, `lua-language-server`, `yaml-language-server` |
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

## 🔌 Plugin Features

- LSP support for Python, YAML, JSON, Bash, Terraform, etc.
- Treesitter-powered syntax + folding
- Completion via `nvim-cmp`, snippets via `LuaSnip`
- Markdown live preview + Mermaid diagram rendering
- File tree, terminal toggling, fuzzy finder
- Git integration with status, blame, and diff
- Harpoon for fast file navigation
- Autopairs, commenting, and code actions

---

## 🧠 Neovim Cheat Sheet (Modern DevSecOps Setup)

### 📌 Basic Navigation

| Key | Action |
| --- | --- |
| `h/j/k/l` | Move left/down/up/right |
| `gg` / `G` | Go to start / end of file |
| `0` / `^` / `$` | Start / first non-blank / end of line |
| `H` / `M` / `L` | Top / middle / bottom of screen |
| `Ctrl+u / Ctrl+d` | Half-page up/down |
| `Ctrl+b / Ctrl+f` | Full-page up/down |
| `{` / `}` | Prev / next paragraph |
| `w/W`, `e/E`, `b/B`, `ge/gE` | Word motions |

### 📌 Buffer & Tab Management

| Command | Action |
| --- | --- |
| `:e file` | Open file |
| `:bn / :bp` | Next / previous buffer |
| `:bd` | Close buffer |
| `:ls` | List open buffers |
| `:tabnew file` | New tab |
| `gt / gT` | Next / previous tab |
| `:tabclose / :tabonly` | Close current / other tabs |

### 📌 Window Splits

| Command | Action |
| --- | --- |
| `:split / :vsplit` | Horizontal / vertical split |
| `Ctrl+w h/j/k/l` | Move between splits |
| `Ctrl+w =` | Equalize splits |
| `Ctrl+w _` | Maximize current split |
| `Ctrl+w q` | Close split |

### 📌 File Explorer (`nvim-tree`)

| Command | Action |
| --- | --- |
| `:NvimTreeToggle` | Toggle file explorer |
| `:NvimTreeFindFile` | Reveal file in tree |
| `<leader>e` | Toggle via shortcut |

### 📌 Markdown & Mermaid Preview

| Command | Action |
| --- | --- |
| `:MarkdownPreview` | Start preview |
| `:MarkdownPreviewToggle` | Toggle preview |
| `<leader>mp` | Shortcut to start preview |
| `mmdc -i input.mmd -o output.png` | Generate diagram via CLI |

### 📌 Editing & Text

| Command | Action |
| --- | --- |
| `i / I` | Insert (cursor / start of line) |
| `a / A` | Append (after / end of line) |
| `o / O` | Open new line (below / above) |
| `x / X` | Delete character (under / before) |
| `dd / yy` | Delete / yank line |
| `p / P` | Paste after / before cursor |
| `u / Ctrl+r` | Undo / redo |
| `.` | Repeat last action |

### 📌 Search & Replace

| Command | Action |
| --- | --- |
| `/pattern` | Search pattern |
| `n / N` | Next / previous match |
| `:%s/old/new/g` | Replace all |
| `:%s/old/new/gc` | Confirm each replacement |
| `* / #` | Search word under cursor (fwd/bwd) |

### 📌 Save & Quit

| Command | Action |
| --- | --- |
| `:w` | Save |
| `:q / :q!` | Quit / force quit |
| `:wq / ZZ` | Save and quit |

### 📌 Git Integration

| Command | Action |
| --- | --- |
| `:G` | Git status |
| `:Gcommit` / `:Gpush` / `:Gpull` | Commit / push / pull |
| `:Gdiffsplit` | View diff |
| `:Gblame` | Blame current line |

### 📌 LSP & Code Actions

| Language | Server |
|----------|--------|
| YAML     | `yaml-language-server` |
| JSON     | `jsonls` (with schemastore) |
| Terraform | `terraform-ls` or formatting-only |

| Key / Command | Action |
| --- | --- |
| `:LspInfo` | View LSP status |
| `K` | Hover docs |
| `gd / gi / gr` | Go to definition / implementation / references |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |

### 📌 Completion & Snippets

| Plugin | Functionality |
| --- | --- |
| `nvim-cmp` | Autocompletion |
| `LuaSnip` | Snippet engine |
| `<Tab>` / `<S-Tab>` | Navigate suggestions |
| `Copilot` (if enabled) | AI suggestions |

### 📌 Formatting (`conform.nvim`)

| Key | Action |
| --- | --- |
| `<leader>f` | Format current file |
| Terraform | `terraform_fmt` |
| Python | `black` |
| JSON / YAML | `prettier` |
| Bash | `shfmt` |

### 📌 Telescope

| Command | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |

### 📌 Terminal Management (`toggleterm`)

| Key | Action |
| --- | --- |
| `<leader>t` | Toggle terminal |
| `Ctrl+\\` then `Ctrl+n` | Exit terminal mode |
| `:ToggleTerm` | Manually toggle terminal |

### 📌 Commenting (`vim-commentary`)

| Command | Action |
| --- | --- |
| `gcc` | Toggle line comment |
| `gc` (Visual) | Toggle selection comment |

### 📌 Code Folding

| Command | Action |
| --- | --- |
| `za / zA` | Toggle fold |
| `zo / zO` | Open fold |
| `zc / zC` | Close fold |
| `zr / zm` | Open / close all folds |

### 📌 UI & Visuals

| Plugin | Feature |
| --- | --- |
| `catppuccin` | Theme |
| `lualine` / `heirline` | Status line |
| `bufferline.nvim` | Tabline |
| `which-key` | Keybinding helper |
| `vim-illuminate` | Word highlighting |
| `todo-comments` | Highlight TODO / FIXME |
| `spectre.nvim` | Search and replace project-wide |

### 📌 Utilities

| Command | Action |
| --- | --- |
| `:checkhealth` | Validate setup |
| `:Lazy sync` | Sync plugins |
| `:Telescope keymaps` | Browse key mappings |
| `:Noice` | View message history |

---

## 🧼 Cleanup

```bash
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
```

---

## 📜 License

MIT License

