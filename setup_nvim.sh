#!/bin/bash

set -e
set -u
set -o pipefail

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

CONFIGS_DIR="$(pwd)/configs"

log_info() { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error() { echo -e "${RED}[ERROR]${RESET} $1"; exit 1; }

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        log_info "macOS detected."
        OS="macOS"
    elif [[ -f "/etc/lsb-release" ]]; then
        log_info "Ubuntu detected."
        OS="Ubuntu"
    else
        log_error "Unsupported OS. Exiting."
    fi
}

is_installed() {
    command -v "$1" >/dev/null 2>&1
}

install_mac() {
    log_info "Installing dependencies for macOS..."
    brew update
    for pkg in neovim git python node ripgrep fzf fd jq terraform lua-language-server; do
        if is_installed "$pkg"; then
            log_info "$pkg is already installed."
        else
            brew install "$pkg"
        fi
    done
}

install_ubuntu() {
    log_info "Installing dependencies for Ubuntu..."
    sudo apt update && sudo apt upgrade -y
    for pkg in neovim git python3 python3-pip nodejs npm ripgrep fzf fd-find jq terraform lua-language-server; do
        if is_installed "$pkg"; then
            log_info "$pkg is already installed."
        else
            sudo apt install -y "$pkg"
        fi
    done
    mkdir -p ~/.local/bin
    ln -sf "$(which fdfind)" ~/.local/bin/fd
}

install_vim_plug() {
    if [[ -f ~/.vim/autoload/plug.vim ]]; then
        log_info "Vim-Plug is already installed."
    else
        log_info "Installing Vim-Plug..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || log_error "Failed to install Vim-Plug."
    fi
}

install_packer() {
    if [[ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
        log_info "Packer.nvim is already installed."
    else
        log_info "Installing Packer.nvim..."
        git clone --depth 1 https://github.com/wbthomason/packer.nvim \
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim || log_error "Failed to install Packer.nvim."
    fi
}

setup_nvim_config() {
    if [[ ! -d "$CONFIGS_DIR" ]]; then
        log_error "Configs directory ($CONFIGS_DIR) not found. Please run this script from the correct location."
    fi

    log_info "Setting up Neovim configuration..."
    mkdir -p ~/.config/nvim

    cp "$CONFIGS_DIR/vimrc" ~/.vimrc
    cp "$CONFIGS_DIR/init.lua" ~/.config/nvim/init.lua
}

log_info "Starting Neovim setup..."
detect_os

if [[ "$OS" == "macOS" ]]; then
    install_mac
elif [[ "$OS" == "Ubuntu" ]]; then
    install_ubuntu
fi

install_vim_plug
install_packer
setup_nvim_config

log_info "Neovim setup complete."
log_info "Open Neovim and run :PlugInstall and :PackerSync"

