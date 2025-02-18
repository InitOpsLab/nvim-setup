🚀 Neovim Auto-Setup Script
Easily set up Neovim with LSP, Treesitter, Debugging, and more on macOS & Ubuntu!



📌 Overview
This script automatically installs and configures Neovim with:
✅ LSP (Language Server Protocol) for code intelligence
✅ Treesitter for advanced syntax highlighting
✅ Autocompletion with nvim-cmp
✅ Git integration with vim-fugitive and gitsigns.nvim
✅ Debugging with nvim-dap
✅ File Navigation with fzf and NERDTree
✅ Autoformatting & Linting with null-ls.nvim
✅ Status bar with lualine.nvim

🔧 Installation
1️⃣ Clone the repository

```
git clone https://github.com/your-username/neovim-setup.git
cd neovim-setup
```

2️⃣ Make the script executable

```
chmod +x setup_nvim.sh
```

3️⃣ Run the script

```
./setup_nvim.sh
```

The script will automatically detect if you're using macOS or Ubuntu and install all required dependencies.

🛠 What the Script Does

✅ OS Detection
Detects if you’re running macOS or Ubuntu and installs dependencies accordingly.

✅ Installs Neovim and Required Packages
macOS: Installs Neovim, Python, Node.js, ripgrep, fzf, fd, jq, terraform, and lua-language-server using brew.
Ubuntu: Installs Neovim, Python, Node.js, ripgrep, fzf, fd-find, jq, terraform, and lua-language-server using apt.

✅ Installs Vim-Plug & Packer.nvim
Vim-Plug: For managing Vim plugins
Packer.nvim: For managing Neovim-specific plugins

✅ Configures Neovim (.vimrc & init.lua)
Creates ~/.vimrc and ~/.config/nvim/init.lua
Pre-configures Neovim with LSP, Treesitter, autocompletion, debugging, and more

🎯 Post-Installation Steps
After running the script, open Neovim:

```
nvim
```

Then, install the plugins:

```
:PlugInstall
```
```
:PackerSync
```

Restart Neovim, and you're ready to go! 🚀

📂 Directory Structure

```
~/.config/nvim/
│── init.lua  # Main Neovim configuration file
│── ~/.vimrc  # Vim configuration, sourced from init.lua
│── plugged/  # Plugin directory (for vim-plug)
```

📜 Configuration Files

.vimrc (Vim Config)
The script automatically sets up your .vimrc with:
✔ Line numbers, relative numbers, clipboard integration
✔ Indentation settings (spaces instead of tabs)
✔ Git integration (vim-fugitive, gitsigns.nvim)
✔ File navigation (fzf, NERDTree)
✔ Debugging (nvim-dap)

init.lua (Neovim Config)
✔ Loads .vimrc for compatibility
✔ Ensures Packer.nvim is installed
✔ Installs LSP, Treesitter, Auto-completion, and Debugging
✔ Configures LSP keybindings for efficient navigation

⌨️ Key Mappings

Keybinding	Action
```
gd	Go to definition
K	Show hover documentation
<leader>rn	Rename symbol
<leader>ca	Code actions
<C-n>	Select next completion
<C-p>	Select previous completion
<C-y>	Confirm completion
<leader>tf	Format Terraform file (terraform fmt)
<leader>fj	Format JSON with jq
<leader>m	Convert Markdown to PNG
```

🎯 Supported Platforms

OS	Supported
macOS	✅ Yes
Ubuntu	✅ Yes
Windows	❌ No (Use WSL)

🛠 Troubleshooting

🚨 Neovim not found?

Make sure it's installed correctly:

```
nvim --version
```

If it’s missing, try reinstalling it using:

```
brew install neovim  # macOS  
```
```
sudo apt install neovim  # Ubuntu  
```

🚨 Packer.nvim or Vim-Plug not working?
Try reinstalling:

```
rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
./setup_nvim.sh
```

🚨 LSP servers not detected?
Ensure Mason is installed and run:

```
:MasonInstall
```

📜 License
This project is licensed under the MIT License. Feel free to use and modify it!

💡 Contributing
Want to improve this script? Fork the repository and submit a pull request! 🚀

🤝 Credits
Special thanks to the Neovim community and plugin authors for their amazing work.

🔥 Enjoy your fully configured Neovim setup! 🎯 🚀
