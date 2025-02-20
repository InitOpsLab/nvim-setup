# Neovim Setup Script

This script automates the installation and configuration of **Neovim** on **macOS** and **Ubuntu**. It installs dependencies, sets up plugin managers, and configures Neovim using files from the local `configs/` directory.

---

## 🚀 Features

- **Auto-detects OS** (macOS or Ubuntu)
- **Installs required dependencies** (Neovim, LSPs, utilities)
- **Checks if dependencies are already installed** before installing
- **Copies Neovim configurations** from the `configs/` directory
- **Installs Vim-Plug & Packer.nvim** for plugin management

---

## 📂 Directory Structure

```
nvim-setup/
│── configs/              # Configuration files for Neovim
│   ├── vimrc             # Neovim main configuration
│   ├── init.lua          # Additional Neovim settings
│── setup_nvim.sh         # Installation script
│── README.md             # Documentation (this file)
```

---

## 💾 Installation

### 1️⃣ Clone this repository

```sh
git clone https://github.com/irussak/nvim-setup.git
cd nvim-setup
```

### 2️⃣ Run the setup script

```sh
chmod +x setup_nvim.sh
./setup_nvim.sh
```

---

## 🛠️ What the Script Does

- Detects the OS (**macOS** or **Ubuntu**)
- Installs required packages (Neovim, LSPs, Git, Node.js, Python, etc.)
- Copies configuration files from `configs/` to `~/.vimrc` and `~/.config/nvim/init.lua`
- Installs **Vim-Plug** (if not installed)
- Installs **Packer.nvim** (if not installed)

---

## 🔧 Post Installation

After running the script, open Neovim and install plugins:

1️⃣ Open Neovim:

```sh
nvim
```

2️⃣ Run the following commands inside Neovim:

```vim
:PlugInstall
:PackerSync
```

---

## 📦 Installed Dependencies

### 🔹 macOS (Homebrew)

```sh
neovim
git
python
node
ripgrep
fzf
fd
jq
terraform
lua-language-server
```

### 🔹 Ubuntu (APT)

```sh
neovim
git
python3
nodejs
npm
ripgrep
fzf
fd-find
jq
terraform
lua-language-server
```

---

## 📜 Troubleshooting

### 🔹 Permission Issues

If you encounter permission errors, run:

```sh
chmod +x setup_nvim.sh
sudo ./setup_nvim.sh
```

### 🔹 Neovim Not Found

If Neovim doesn’t launch after installation, restart your terminal or run:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

---

## 📌 Contributing

Feel free to open an **issue** or **pull request** if you have improvements or bug fixes.

---

## 📜 License

This script is open-source and available under the **MIT License**.

---

🎯 **Now your Neovim is fully configured and ready to use! 🚀**

