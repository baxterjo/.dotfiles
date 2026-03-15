#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_URL=https://github.com/baxterjo/.dotfiles.git
REPO_PATH="$HOME/.dotfiles"

if [ -z "${REPO_BRANCH+x}" ]; then
  REPO_BRANCH=main
fi

reset_color=$(tput sgr 0)

info() {
  printf "%s[*] %s%s\n" "$(tput setaf 4)" "$1" "$reset_color"
}

success() {
  printf "%s[*] %s%s\n" "$(tput setaf 2)" "$1" "$reset_color"
}

err() {
  printf "%s[*] %s%s\n" "$(tput setaf 1)" "$1" "$reset_color"
}

warn() {
  printf "%s[*] %s%s\n" "$(tput setaf 3)" "$1" "$reset_color"
}

bootstrap() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &>/dev/null; then
      info "Installing Homebrew..."
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    brew install git stow
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update -y
    sudo apt-get install -y git curl stow
  else
    err "${OSTYPE} not supported."
    exit 1
  fi
}

install_packages() {
  info "Installing tmux and neovim..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install tmux neovim
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get install -y tmux neovim
  fi
}

clone_repo() {
  if [ -d "$REPO_PATH/.git" ]; then
    existing_remote=$(git -C "$REPO_PATH" config --get remote.origin.url 2>/dev/null)
    if [ "$existing_remote" = "$REPO_URL" ]; then
      info "Repo already exists, pulling latest..."
      git -C "$REPO_PATH" checkout "$REPO_BRANCH"
      git -C "$REPO_PATH" pull
    else
      err "Repository at $REPO_PATH has a different origin: $existing_remote"
      exit 1
    fi
  else
    info "Cloning $REPO_URL..."
    git clone -b "$REPO_BRANCH" "$REPO_URL" "$REPO_PATH"
  fi
}

stow_configs() {
  local files=(".tmux.conf")
  local folders=(".config/nvim")

  for f in "${files[@]}"; do
    rm -f "$HOME/$f" || true
  done

  for d in "${folders[@]}"; do
    rm -rf "${HOME:?}/$d" || true
    mkdir -p "$HOME/$d"
  done

  info "Stowing tmux and nvim configs..."
  stow -d "$REPO_PATH/stow" --verbose 1 --target "${HOME}" tmux nvim
}

main() {
  info "Remote editor setup"

  bootstrap
  clone_repo
  install_packages
  stow_configs

  success "Done"
}

main
