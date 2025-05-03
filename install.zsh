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

printf "\nWelcome to ${BOLD_MAGENTA}D3CL4NZ's dotfile installation script${RESET}!\n"
printf "[${BOLD_YELLOW}!${RESET}] ${BOLD_CYAN}This script is meant to be executed on ArchLinux.${RESET}\n\n"

# Check if git is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for git..."
command -v git > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}git${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for git...\n"

# Check if alacritty is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for alacritty..."
command -v alacritty > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}alacritty${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for alacritty...\n"

# Check if oh-my-zsh is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for oh-my-zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    printf "\r[${BOLD_GREEN}✔${RESET}] Checking for oh-my-zsh...\n"
else
    printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}oh-my-zsh${RESET} ${RED}is not installed.${RESET}\n"
    exit 1
fi

# Check if powerlevel10k is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for powerlevel10k..."
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    printf "\r[${BOLD_GREEN}✔${RESET}] Checking for powerlevel10k...\n"
else
    printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}powerlevel10k${RESET} ${RED}is not installed.${RESET}\n"
    exit 1
fi

# Check if i3 is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for i3..."
command -v i3 > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}i3${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for i3...\n"

# Check if fontconfig is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for fontconfig..."
command -v git > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}fontconfig${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for fontconfig...\n"

# Check if Meslo Nerd Fonts are installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for ttf-meslo-nerd..."
if fc-list | grep -i "MesloLGM Nerd Font" >/dev/null 2>&1; then
  printf "\r[${BOLD_GREEN}✔${RESET}] Checking for ttf-meslo-nerd...\n"
else
  printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}ttf-meslo-nerd${RESET} ${RED}is not installed.${RESET}\n"
  exit 1
fi

# Check if zsh-syntax-highlighting is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for zsh-syntax-highlighting..."
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    printf "\r[${BOLD_GREEN}✔${RESET}] Checking for zsh-syntax-highlighting...\n"
else
    printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}zsh-syntax-highlighting${RESET} ${RED}is not installed.${RESET}\n"
    exit 1
fi

# Check if zsh-autosuggestions is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for zsh-autosuggestions..."
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    printf "\r[${BOLD_GREEN}✔${RESET}] Checking for zsh-autosuggestions...\n"
else
    printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}zsh-autosuggestions${RESET} ${RED}is not installed.${RESET}\n"
    exit 1
fi

# Check if rubygems is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for gem..."
command -v gem > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}gem${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for gem...\n"

# Check if colorls is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for colorls..."
if gem list --local | grep -i "colorls" >/dev/null 2>&1; then
  printf "\r[${BOLD_GREEN}✔${RESET}] Checking for colorls...\n"
else
  printf "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}colorls${RESET} ${RED}is not installed.${RESET}\n"
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

printf "\n[${BOLD_GREEN}了${RESET}] ${BOLD_GREEN}Installation completed without errors.${RESET}\n\n"
exit 0
