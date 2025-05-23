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
printf "[${BOLD_YELLOW}!${RESET}] ${BOLD_CYAN}This script is designed for ArchLinux.${RESET}\n\n"

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
command -v fc-list > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}fontconfig${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
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

# Check if dex is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for dex..."
command -v dex > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}dex${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for dex...\n"

# Check if picom is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for picom..."
command -v picom > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}picom${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for picom...\n"

# Check if feh is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for feh..."
command -v feh > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}feh${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for feh...\n"

# Check if dunst is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for dunst..."
command -v dunst > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}dunst${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for dunst...\n"

# Check if xss-lock is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for xss-lock..."
command -v xss-lock > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}xss-lock${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for xss-lock...\n"

# Check if nm-applet is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for nm-applet..."
command -v nm-applet > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}nm-applet${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for nm-applet...\n"

# Check if dmenu is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for dmenu..."
command -v dmenu_run > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}dmenu${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for dmenu...\n"

# Check if maim is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for maim..."
command -v maim > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}maim${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for maim...\n"

# Check if xdotool is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for xdotool..."
command -v xdotool > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}xdotool${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for xdotool...\n"

# Check if xclip is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for xclip..."
command -v xclip > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}xclip${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for xclip...\n"

# Check if dunst is installed
printf "[${BOLD_YELLOW}•${RESET}] Checking for dunst..."
command -v dunst > /dev/null 2>&1 || { printf >&2 "\r[${BOLD_RED}✘${RESET}] ${BOLD_MAGENTA}dunst${RESET} ${RED}is not installed.${RESET}\n"; exit 1; }
printf "\r[${BOLD_GREEN}✔${RESET}] Checking for dunst...\n"

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

# Ensure ~/.config/alacritty exists
mkdir -p "$HOME/.config/alacritty"

# Alacritty
printf "[${BOLD_YELLOW}•${RESET}] Installing config for alacritty..."
if [[ -f "$HOME/.config/alacritty/alacritty.toml" ]]; then
    rm -f $HOME/.config/alacritty/alacritty.toml
    ln -sf $DOTFILES_DIR/config/alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml
else
    ln -sf $DOTFILES_DIR/config/alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml
fi
if [[ -f "$HOME/.config/alacritty/dark-pastel.toml" ]]; then
    rm -f $HOME/.config/alacritty/dark-pastel.toml
    ln -sf $DOTFILES_DIR/config/alacritty/dark-pastel.toml $HOME/.config/alacritty/dark-pastel.toml
else
    ln -sf $DOTFILES_DIR/config/alacritty/dark-pastel.toml $HOME/.config/alacritty/dark-pastel.toml
fi
if [[ -f "$HOME/.config/alacritty/vaporwave.toml" ]]; then
    rm -f $HOME/.config/alacritty/vaporwave.toml
    ln -sf $DOTFILES_DIR/config/alacritty/vaporwave.toml $HOME/.config/alacritty/vaporwave.toml
else
    ln -sf $DOTFILES_DIR/config/alacritty/vaporwave.toml $HOME/.config/alacritty/vaporwave.toml
fi
printf "\r[${BOLD_GREEN}✔${RESET}] Installing config for alacritty...\n"

# Ensure ~/.config/i3 and ~/.config/i3status exist
mkdir -p "$HOME/.config/i3"
mkdir -p "$HOME/.config/i3status"

# i3
printf "[${BOLD_YELLOW}•${RESET}] Installing config for i3..."
if [[ -f "$HOME/.config/i3/config" ]]; then
    rm -f $HOME/.config/i3/config
    ln -sf $DOTFILES_DIR/config/i3/config $HOME/.config/i3/config
else
    ln -sf $DOTFILES_DIR/config/i3/config $HOME/.config/i3/config
fi
if [[ -f "$HOME/.config/i3status/config" ]]; then
    rm -f $HOME/.config/i3status/config
    ln -sf $DOTFILES_DIR/config/i3status/config $HOME/.config/i3status/config
else
    ln -sf $DOTFILES_DIR/config/i3status/config $HOME/.config/i3status/config
fi
printf "\r[${BOLD_GREEN}✔${RESET}] Installing config for i3...\n"

# Ensure ~/.config/picom exists
mkdir -p "$HOME/.config/picom"

# picom
printf "[${BOLD_YELLOW}•${RESET}] Installing config for picom..."
if [[ -f "$HOME/.config/picom/picom.conf" ]]; then
    rm -f $HOME/.config/picom/picom.conf
    ln -sf $DOTFILES_DIR/config/picom/picom.conf $HOME/.config/picom/picom.conf
else
    ln -sf $DOTFILES_DIR/config/picom/picom.conf $HOME/.config/picom/picom.conf
fi
printf "\r[${BOLD_GREEN}✔${RESET}] Installing config for picom...\n"

# Ensure ~/.config/dunst exists
mkdir -p "$HOME/.config/dunst"

# dunst
printf "[${BOLD_YELLOW}•${RESET}] Installing config for dunst..."
if [[ -f "$HOME/.config/dunst/dunstrc" ]]; then
    rm -f $HOME/.config/dunst/dunstrc
    ln -sf $DOTFILES_DIR/config/dunst/dunstrc $HOME/.config/dunst/dunstrc
else
    ln -sf $DOTFILES_DIR/config/dunst/dunstrc $HOME/.config/dunst/dunstrc
fi
printf "\r[${BOLD_GREEN}✔${RESET}] Installing config for dunst...\n"

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
