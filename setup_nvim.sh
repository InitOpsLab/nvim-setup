#!/bin/bash

set -euo pipefail

GREEN="\\033[1;32m"
YELLOW="\\033[1;33m"
RED="\\033[1;31m"
RESET="\\033[0m"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_DIR="$SCRIPT_DIR/configs"

log_info() { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error() {
  echo -e "${RED}[ERROR]${RESET} $1"
  exit 1
}

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    log_info "macOS detected."
    OS="macOS"
  elif grep -qi ubuntu /etc/os-release 2>/dev/null; then
    log_info "Ubuntu detected."
    OS="Ubuntu"
  else
    log_error "Unsupported OS. Exiting."
  fi
}

is_installed() {
  command -v "$1" >/dev/null 2>&1
}

# Map package names to their actual command names
get_command_name() {
  local pkg="$1"
  case "$pkg" in
    neovim) echo "nvim" ;;
    python|python3) echo "python3" ;;
    nodejs|node) echo "node" ;;
    fd|fd-find) echo "fd" ;;
    lua-language-server) echo "lua-language-server" ;;
    ripgrep) echo "rg" ;;
    bat) echo "bat" ;;
    *) echo "$pkg" ;;
  esac
}

install_mac() {
  log_info "Installing dependencies for macOS..."
  brew update

  local packages=(neovim git python node ripgrep fzf fd jq terraform
    lua-language-server gh bat yq eza)

  for pkg in "${packages[@]}"; do
    local cmd
    cmd=$(get_command_name "$pkg")
    if is_installed "$cmd"; then
      log_info "$pkg is already installed."
    else
      brew install "$pkg"
    fi
  done

  # Install npm-based tools
  npm install -g @mermaid-js/mermaid-cli yaml-language-server vscode-langservers-extracted
}

install_ubuntu() {
  log_info "Installing dependencies for Ubuntu..."
  sudo apt update

  # Add Neovim PPA for latest version
  if ! is_installed "nvim"; then
    log_info "Adding Neovim PPA..."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
  fi

  # Add HashiCorp repo for terraform
  if ! is_installed "terraform"; then
    log_info "Adding HashiCorp repository..."
    sudo apt install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
  fi

  # Core packages available in Ubuntu repos
  local packages=(neovim git python3 python3-pip nodejs npm ripgrep fzf fd-find jq terraform gh bat)

  for pkg in "${packages[@]}"; do
    local cmd
    cmd=$(get_command_name "$pkg")
    # Special case: fd-find installs as fdfind on Ubuntu
    if [[ "$pkg" == "fd-find" ]]; then
      cmd="fdfind"
    fi
    if is_installed "$cmd"; then
      log_info "$pkg is already installed."
    else
      sudo apt install -y "$pkg" || log_warn "Failed to install $pkg, skipping..."
    fi
  done

  # Create fd symlink if fdfind exists
  if is_installed "fdfind"; then
    mkdir -p ~/.local/bin
    ln -sf "$(which fdfind)" ~/.local/bin/fd
    log_info "Created fd symlink."
  fi

  # Install tools not in Ubuntu repos via other methods
  if ! is_installed "lua-language-server"; then
    log_info "Installing lua-language-server via GitHub release..."
    local lls_version="3.7.4"
    local lls_dir="$HOME/.local/share/lua-language-server"
    mkdir -p "$lls_dir"
    curl -L "https://github.com/LuaLS/lua-language-server/releases/download/${lls_version}/lua-language-server-${lls_version}-linux-x64.tar.gz" | tar xz -C "$lls_dir"
    mkdir -p ~/.local/bin
    ln -sf "$lls_dir/bin/lua-language-server" ~/.local/bin/lua-language-server
  fi

  if ! is_installed "yq"; then
    log_info "Installing yq via GitHub release..."
    sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
    sudo chmod +x /usr/local/bin/yq
  fi

  if ! is_installed "eza"; then
    log_info "Installing eza via cargo..."
    if is_installed "cargo"; then
      cargo install eza
    else
      log_warn "cargo not installed, skipping eza installation."
    fi
  fi

  # Install npm-based tools
  sudo npm install -g @mermaid-js/mermaid-cli yaml-language-server vscode-langservers-extracted
}

install_lazy_nvim() {
  local lazy_path="$HOME/.local/share/nvim/lazy/lazy.nvim"
  if [[ -d "$lazy_path" ]]; then
    log_info "lazy.nvim is already installed."
  else
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$lazy_path" || log_error "Failed to install lazy.nvim."
  fi
}

install_jira_tool() {
  local jira_tool_tar="$SCRIPT_DIR/jira-tool.tar.gz"
  
  if [[ ! -f "$jira_tool_tar" ]]; then
    log_warn "jira-tool.tar.gz not found, skipping jira-tool installation."
    return
  fi

  log_info "Installing jira-tool..."

  # Extract tar.gz to temp directory
  local temp_dir
  temp_dir=$(mktemp -d)
  trap "rm -rf $temp_dir" EXIT
  
  tar -xzf "$jira_tool_tar" -C "$temp_dir" || log_error "Failed to extract jira-tool.tar.gz"

  local jira_tool_dir="$temp_dir/jira-tool"
  if [[ ! -d "$jira_tool_dir" ]]; then
    log_error "jira-tool directory not found in archive."
  fi

  # 1. Install CLI binary
  if [[ -f "$jira_tool_dir/bin/jira" ]]; then
    mkdir -p ~/.local/bin
    cp "$jira_tool_dir/bin/jira" ~/.local/bin/jira
    chmod +x ~/.local/bin/jira
    log_info "jira CLI installed to ~/.local/bin/jira"
  else
    log_warn "jira binary not found in archive."
  fi

  # 2. Setup jira config directory
  mkdir -p ~/.jira/templates
  log_info "jira config directory ready at ~/.jira"

  # 3. Install zsh integration (optional)
  if [[ -f "$jira_tool_dir/zsh/jira.zsh" ]]; then
    if [[ -d ~/.zsh/functions ]]; then
      cp "$jira_tool_dir/zsh/jira.zsh" ~/.zsh/functions/jira.zsh
      log_info "Zsh integration installed to ~/.zsh/functions/jira.zsh"
      
      # Check if already sourced
      if [[ -f ~/.zsh/functions.zsh ]] && ! grep -q "jira.zsh" ~/.zsh/functions.zsh 2>/dev/null; then
        log_warn "Add to ~/.zsh/functions.zsh: [[ -f ~/.zsh/functions/jira.zsh ]] && source ~/.zsh/functions/jira.zsh"
      fi
    elif [[ -d ~/.zsh ]]; then
      cp "$jira_tool_dir/zsh/jira.zsh" ~/.zsh/jira.zsh
      log_info "Zsh integration installed to ~/.zsh/jira.zsh"
      log_warn "Add to ~/.zshrc: [[ -f ~/.zsh/jira.zsh ]] && source ~/.zsh/jira.zsh"
    else
      mkdir -p ~/.zsh/functions
      cp "$jira_tool_dir/zsh/jira.zsh" ~/.zsh/functions/jira.zsh
      log_info "Zsh integration installed to ~/.zsh/functions/jira.zsh"
      log_warn "Add to ~/.zshrc: [[ -f ~/.zsh/functions/jira.zsh ]] && source ~/.zsh/functions/jira.zsh"
    fi
  fi

  # 4. Check PATH
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    log_warn "~/.local/bin not in PATH. Add to ~/.zshrc: export PATH=\"\$HOME/.local/bin:\$PATH\""
  fi

  # Note: Neovim plugin files are already in the repo and will be installed by setup_nvim_config
  log_info "jira-tool installation complete. Run 'jira setup' to configure credentials."
}

setup_nvim_config() {
  if [[ ! -d "$CONFIGS_DIR" ]]; then
    log_error "Configs directory ($CONFIGS_DIR) not found. Please run this script from the correct location."
  fi

  log_info "Setting up Neovim configuration..."

  # Backup existing config if present
  if [[ -d ~/.config/nvim ]]; then
    local backup_dir
    backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    log_warn "Existing Neovim config found. Backing up to $backup_dir"
    mv ~/.config/nvim "$backup_dir"
  fi

  mkdir -p ~/.config/nvim
  cp "$CONFIGS_DIR/init.lua" ~/.config/nvim/init.lua
  cp -r "$CONFIGS_DIR/lua" ~/.config/nvim/

  # Auto-sync plugins
  log_info "Running Lazy sync..."
  if ! nvim --headless "+Lazy! sync" +qa 2>&1; then
    log_warn "Lazy sync encountered issues. You may need to run :Lazy sync manually in Neovim."
  fi
}

# === Run Setup ===
log_info "Starting Neovim setup..."
detect_os

if [[ "$OS" == "macOS" ]]; then
  install_mac
elif [[ "$OS" == "Ubuntu" ]]; then
  install_ubuntu
fi

install_lazy_nvim
install_jira_tool
setup_nvim_config

log_info "Neovim setup complete"
