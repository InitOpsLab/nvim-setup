# \# ⚡ Neovim Configuration (DevSecOps Ready)

This repository contains a **modern, fast, and productive Neovim
configuration** tailored for development and DevSecOps workflows.

### ✨ Highlights

-   🌐 Language Server Protocol (LSP) support via `mason.nvim`
-   🧠 Autocompletion with `nvim-cmp`
-   🌈 Tree-sitter syntax highlighting
-   📄 Markdown & Mermaid preview
-   🛠 Supports YAML, Python, Bash, Terraform, Docker, Kubernetes, SQL,
    JSON, HCL, and more
-   🚀 Powered by `lazy.nvim` for lazy-loading and performance

------------------------------------------------------------------------

## 🚀 Features

-   📦 Plugin management with `lazy.nvim`
-   🌍 LSP configuration via `mason.nvim` and `nvim-lspconfig`
-   🧱 Code formatting with `conform.nvim` and `null-ls.nvim`
-   🔎 Fuzzy finding with `telescope.nvim`
-   🗂 File explorer, terminal toggler, Harpoon bookmarks
-   🎯 Focused productivity with TODOs, smart motions, UI polish

------------------------------------------------------------------------

## 🛠 Installation

### 1️⃣ Install Prerequisites

#### On **macOS**:

``` bash
brew install neovim git python node ripgrep fzf fd jq terraform lua-language-server
```

On Ubuntu:

    sudo apt update
    sudo apt install neovim git python3 python3-pip nodejs npm ripgrep fzf fd-find jq terraform lua-language-server

2️⃣ Clone This Configuration

    git clone <this-repo-url> ~/nvim-setup
    cd ~/nvim-setup
    ./setup.sh

This script:

Installs lazy.nvim Sets up config in \~/.config/nvim/ Ensures all
required tools are installed

3️⃣ Open Neovim & Install Plugins

    nvim

Then run inside Neovim:

    :Lazy sync

📦 Plugin Overview Plugin Purpose lazy.nvim Plugin manager
nvim-treesitter Syntax highlighting mason.nvim + lspconfig LSP
installation & setup nvim-cmp + LuaSnip Autocomplete + snippets
null-ls.nvim + conform.nvim Formatters & linters nvim-tree.lua File
explorer toggleterm.nvim Terminal inside Neovim harpoon Quick file
nav/bookmarking telescope.nvim File/search fuzzy finder
markdown-preview.nvim Markdown + Mermaid live preview todo-comments.nvim
Highlight TODO/FIXME/etc indent-blankline.nvim Indentation guides
spectre.nvim Project-wide search & replace noice.nvim + notify.nvim
Better UI for messages which-key.nvim Popup keybinding hints
lualine.nvim, bufferline Status and buffer line

🧠 Supported Languages Language LSP Formatter Python pyright black JSON
jsonls prettier YAML yamlls prettier Bash bashls shfmt Terraform/HCL
terraformls terraform_fmt SQL sqlls sqlfmt / sqlparse Lua lua_ls
Built-in Docker dockerls --- Markdown --- Preview only

🎯 Keybindings Keybinding Action `<leader>`{=html}f Format current
buffer `<leader>`{=html}e Toggle file explorer `<leader>`{=html}t Toggle
terminal `<leader>`{=html}mp Markdown preview `<leader>`{=html}ff Find
file (Telescope) `<leader>`{=html}fg Live grep (Telescope)
`<leader>`{=html}td List TODO comments `<leader>`{=html}ha Add Harpoon
bookmark `<leader>`{=html}hh Show Harpoon UI `<leader>`{=html}hn Harpoon
next file `<leader>`{=html}hp Harpoon previous file `<leader>`{=html}S
Open Spectre (search/replace) `<leader>`{=html}nl Open message log
(Noice)

🎨 UI & Theme 🌈 Colorscheme: catppuccin

📊 Status Line: lualine

📂 Icons: nvim-web-devicons

⌨️ Key help: which-key

🔔 Notifications: notify, noice

✅ Troubleshooting Run diagnostics inside Neovim:

    :checkhealth

To reinstall or fix plugin issues:

    :Lazy sync

📜 License MIT License

🤝 Contributing Contributions, bug reports, and pull requests are
welcome! Feel free to fork, tweak, and share improvements 🚀

Happy hacking! 💻⚡ --- Made with ❤️ using Neovim

Let me know if you want this saved to a file or included as a
downloadable starter repo!
