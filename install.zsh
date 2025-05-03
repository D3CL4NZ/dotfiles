#!/bin/zsh
set -euo pipefail

REPO_URL="https://github.com/D3CL4NZ/dotfiles.git"
DOTFILES_DIR="$HOME/.config/dotfiles"

# Colors :D
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"
BOLD_RED="\033[1;31m"
BOLD_GREEN="\033[1;32m"
BOLD_YELLOW="\033[1;33m"
BOLD_BLUE="\033[1;34m"
BOLD_MAGENTA="\033[1;35m"
BOLD_CYAN="\033[1;36m"
BOLD_WHITE="\033[1;37m"
RESET="\033[0m" # Reset to default color
BOLD_RESET="\033[0m\033[1m"

printf "\nWelcome to D3CL4NZ's dotfile installation script!\n"
printf "[${BOLD_YELLOW}!${RESET}] ${BOLD_CYAN}This script is meant to be executed on ArchLinux.${RESET}\n\n"

if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  if [[ "${ID,,}" != "arch" ]]; then
    printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}OS check failed.${RESET}\n"
    exit 1
  fi
else
  printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}OS check failed.${RESET}\n"
  exit 1
fi

printf "[${BOLD_YELLOW}•${RESET}] Checking for git..."
command -v git > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}Git is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for git...\n"

printf "[${BOLD_YELLOW}•${RESET}] Checking for oh-my-zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    printf "\r[${BOLD_GREEN}✔${RESET}] Checking for oh-my-zsh...\n"
else
    printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}Oh-my-zsh is not installed.${RESET}\n"
    exit 1
fi

printf "[${BOLD_YELLOW}•${RESET}] Checking for powerlevel10k..."
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    printf "\r[${BOLD_GREEN}✔${RESET}] Checking for powerlevel10k...\n"
else
    printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}Powerlevel10k is not installed.${RESET}\n"
    exit 1
fi

printf "\nDependency check complete. Beginning installation...\n"

# Clone or update the repo
if [[ -d "$DOTFILES_DIR/.git" ]]; then
    printf "[${BOLD_YELLOW}•${RESET}] Updating existing dotfiles repo..."
    git -C "$DOTFILES_DIR" pull --rebase > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}Updating existing dotfiles repo...${RESET}\n"; exit 1; }
    printf "\r[${BOLD_GREEN}✔${RESET}] Updating existing dotfiles repo...\n"
else
    printf "[${BOLD_YELLOW}•${RESET}] Cloning dotfiles into $DOTFILES_DIR..."
    git clone "$REPO_URL" "$DOTFILES_DIR" > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_RED}Cloning dotfiles into $DOTFILES_DIR...${RESET}\n"; exit 1;}
    printf "\r[${BOLD_GREEN}✔${RESET}] Cloning dotfiles into $DOTFILES_DIR...\n"
fi

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Powerlevel10k
printf "[${BOLD_YELLOW}•${RESET}] Installing config for powerlevel10k..."
if [[ -f "$HOME/.p10k.zsh" ]]; then
    rm -f $HOME/.p10k.zsh
    ln -sf $DOTFILES_DIR/config/p10k.zsh $HOME/.p10k.zsh
else
    ln -sf $DOTFILES_DIR/config/p10k.zsh $HOME/.p10k.zsh
fi
printf "\r[${BOLD_GREEN}✔${RESET}] Installing config for powerlevel10k...\n"

# .zshrc (This should go last)
printf "[${BOLD_YELLOW}•${RESET}] Updating zshrc..."
if [[ -f "$HOME/.zshrc" ]]; then
    if [[ -f "$HOME/.zshrc.backup" ]]; then
        rm -f $HOME/.zshrc
    else
        mv $HOME/.zshrc $HOME/.zshrc.backup
    fi
    ln -sf $DOTFILES_DIR/config/zshrc $HOME/.zshrc
else
    ln -sf $DOTFILES_DIR/config/zshrc $HOME/.zshrc
fi
printf "\r[${BOLD_GREEN}✔${RESET}] Updating zshrc...\n"

printf "\n[${BOLD_GREEN}✔${RESET}] ${BOLD_GREEN}Installation completed without errors.${RESET}\n\n"
exit 0
