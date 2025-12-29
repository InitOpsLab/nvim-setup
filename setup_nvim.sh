#!/bin/bash

set -euo pipefail

GREEN="\\033[1;32m"
YELLOW="\\033[1;33m"
RED="\\033[1;31m"
RESET="\\033[0m"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_DIR="$SCRIPT_DIR/configs"

# Default flags
SKIP_DEPS=false
SKIP_JIRA=false
SKIP_LAZY=false
SKIP_SYNC=false
NO_BACKUP=false
VERBOSE=false

log_info() { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error() {
  echo -e "${RED}[ERROR]${RESET} $1"
  exit 1
}

show_usage() {
  cat << EOF
Usage: $0 [OPTIONS]

Install Neovim configuration with dependencies and plugins.

OPTIONS:
    --skip-deps       Skip installing system dependencies (brew/apt packages)
    --skip-jira       Skip jira-tool installation
    --skip-lazy       Skip lazy.nvim plugin manager installation
    --skip-sync       Skip Lazy plugin sync after config installation
    --no-backup       Don't backup existing ~/.config/nvim directory
    --verbose         Enable verbose output
    -h, --help        Show this help message

EXAMPLES:
    $0                          # Full installation
    $0 --skip-deps              # Skip dependency installation
    $0 --skip-jira --skip-sync  # Skip jira and plugin sync
    $0 --no-backup              # Don't backup existing config

EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      --skip-deps)
        SKIP_DEPS=true
        shift
        ;;
      --skip-jira)
        SKIP_JIRA=true
        shift
        ;;
      --skip-lazy)
        SKIP_LAZY=true
        shift
        ;;
      --skip-sync)
        SKIP_SYNC=true
        shift
        ;;
      --no-backup)
        NO_BACKUP=true
        shift
        ;;
      --verbose)
        VERBOSE=true
        shift
        ;;
      -h|--help)
        show_usage
        exit 0
        ;;
      *)
        log_error "Unknown option: $1\nRun '$0 --help' for usage information."
        ;;
    esac
  done
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

# Check for required prerequisites
check_prerequisites() {
  local missing_tools=()
  
  # Common tools needed
  local required_tools=("git" "tar")
  
  if [[ "$OS" == "macOS" ]]; then
    if ! is_installed "brew"; then
      log_error "Homebrew is not installed. Please install it from https://brew.sh"
    fi
    required_tools+=("curl")
  elif [[ "$OS" == "Ubuntu" ]]; then
    required_tools+=("curl" "wget")
  fi
  
  for tool in "${required_tools[@]}"; do
    if ! is_installed "$tool"; then
      missing_tools+=("$tool")
    fi
  done
  
  if [[ ${#missing_tools[@]} -gt 0 ]]; then
    log_error "Missing required tools: ${missing_tools[*]}. Please install them first."
  fi
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
  if is_installed "npm"; then
    log_info "Installing npm-based tools..."
    npm install -g @mermaid-js/mermaid-cli yaml-language-server vscode-langservers-extracted || log_warn "Failed to install some npm packages"
  else
    log_warn "npm not found, skipping npm package installation"
  fi
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
    local arch
    arch=$(uname -m)
    local lls_arch="linux-x64"
    
    # Detect architecture
    case "$arch" in
      x86_64) lls_arch="linux-x64" ;;
      aarch64|arm64) lls_arch="linux-arm64" ;;
      *) log_warn "Unsupported architecture $arch for lua-language-server, skipping"; return ;;
    esac
    
    local lls_dir="$HOME/.local/share/lua-language-server"
    mkdir -p "$lls_dir"
    if curl -L "https://github.com/LuaLS/lua-language-server/releases/download/${lls_version}/lua-language-server-${lls_version}-${lls_arch}.tar.gz" | tar xz -C "$lls_dir" 2>/dev/null; then
      mkdir -p ~/.local/bin
      ln -sf "$lls_dir/bin/lua-language-server" ~/.local/bin/lua-language-server
      log_info "lua-language-server installed successfully"
    else
      log_warn "Failed to install lua-language-server, skipping"
    fi
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
  if is_installed "npm"; then
    log_info "Installing npm-based tools..."
    sudo npm install -g @mermaid-js/mermaid-cli yaml-language-server vscode-langservers-extracted || log_warn "Failed to install some npm packages"
  else
    log_warn "npm not found, skipping npm package installation"
  fi
}

install_lazy_nvim() {
  if ! is_installed "git"; then
    log_error "git is required but not installed. Please install git first."
  fi
  
  local lazy_path="$HOME/.local/share/nvim/lazy/lazy.nvim"
  if [[ -d "$lazy_path" ]]; then
    log_info "lazy.nvim is already installed."
  else
    log_info "Installing lazy.nvim..."
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
  
  # Cleanup function for temp directory
  local cleanup_temp=1
  cleanup_jira_temp() {
    if [[ "$cleanup_temp" -eq 1 ]] && [[ -n "$temp_dir" ]] && [[ -d "$temp_dir" ]]; then
      rm -rf "$temp_dir" 2>/dev/null || true
    fi
  }
  
  # Ensure cleanup on exit
  trap cleanup_jira_temp EXIT INT TERM
  
  if ! tar -xzf "$jira_tool_tar" -C "$temp_dir" 2>/dev/null; then
    log_error "Failed to extract jira-tool.tar.gz"
  fi

  local jira_tool_dir="$temp_dir/jira-tool"
  if [[ ! -d "$jira_tool_dir" ]]; then
    log_error "jira-tool directory not found in archive."
  fi

  # 1. Install CLI binary
  if [[ -f "$jira_tool_dir/bin/jira" ]]; then
    mkdir -p ~/.local/bin
    local jira_bin="$HOME/.local/bin/jira"
    
    # Check if jira already exists and warn
    if [[ -f "$jira_bin" ]]; then
      log_warn "jira binary already exists at $jira_bin, overwriting..."
    fi
    
    if cp "$jira_tool_dir/bin/jira" "$jira_bin" && chmod +x "$jira_bin"; then
      log_info "jira CLI installed to $jira_bin"
      cleanup_temp=0  # Success, cleanup will happen via trap
    else
      log_error "Failed to install jira CLI binary"
    fi
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

  # 4. Check PATH (check common shell config files)
  local local_bin="$HOME/.local/bin"
  local path_in_shell=false
  
  # Check if it's in current PATH
  if [[ ":$PATH:" == *":$local_bin:"* ]]; then
    path_in_shell=true
  fi
  
  # Check common shell config files
  local shell_configs=()
  if [[ -n "${ZSH_VERSION:-}" ]] || [[ -f ~/.zshrc ]]; then
    shell_configs+=("~/.zshrc")
  fi
  if [[ -n "${BASH_VERSION:-}" ]] || [[ -f ~/.bashrc ]]; then
    shell_configs+=("~/.bashrc")
  fi
  
  if [[ "$path_in_shell" == "false" ]]; then
    local config_found=false
    for config in "${shell_configs[@]}"; do
      local expanded_config="${config/#\~/$HOME}"
      if [[ -f "$expanded_config" ]] && grep -q "\.local/bin" "$expanded_config" 2>/dev/null; then
        config_found=true
        break
      fi
    done
    
    if [[ "$config_found" == "false" ]]; then
      log_warn "~/.local/bin not in PATH. Add to your shell config: export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
  fi

  # Cleanup temp directory
  cleanup_jira_temp
  trap - EXIT INT TERM  # Remove trap since we cleaned up manually
  
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
    if [[ "$NO_BACKUP" == "true" ]]; then
      log_warn "Existing Neovim config found. Removing (--no-backup specified)..."
      rm -rf ~/.config/nvim
    else
      local backup_dir
      backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
      log_warn "Existing Neovim config found. Backing up to $backup_dir"
      mv ~/.config/nvim "$backup_dir"
    fi
  fi

  mkdir -p ~/.config/nvim
  cp "$CONFIGS_DIR/init.lua" ~/.config/nvim/init.lua
  cp -r "$CONFIGS_DIR/lua" ~/.config/nvim/

  # Auto-sync plugins
  if [[ "$SKIP_SYNC" == "false" ]]; then
    log_info "Running Lazy sync..."
    if ! nvim --headless "+Lazy! sync" +qa 2>&1; then
      log_warn "Lazy sync encountered issues. You may need to run :Lazy sync manually in Neovim."
    fi
  else
    log_info "Skipping Lazy sync (--skip-sync specified)"
  fi
}

# === Parse Arguments ===
parse_args "$@"

# === Run Setup ===
log_info "Starting Neovim setup..."
detect_os

if [[ "$SKIP_DEPS" == "false" ]]; then
  check_prerequisites
  
  if [[ "$OS" == "macOS" ]]; then
    install_mac
  elif [[ "$OS" == "Ubuntu" ]]; then
    install_ubuntu
  fi
else
  log_info "Skipping dependency installation (--skip-deps specified)"
fi

if [[ "$SKIP_LAZY" == "false" ]]; then
  install_lazy_nvim
else
  log_info "Skipping lazy.nvim installation (--skip-lazy specified)"
fi

if [[ "$SKIP_JIRA" == "false" ]]; then
  install_jira_tool
else
  log_info "Skipping jira-tool installation (--skip-jira specified)"
fi

setup_nvim_config

log_info "Neovim setup complete"
