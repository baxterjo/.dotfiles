setup_github_ssh() {
  if [ -z ${SSH_PASSPHRASE+x} ]; then
    echo "SSH_PASSPHRASE not set"
  else
    info "Using $SSH_PASSPHRASE"
    ssh-keygen -t ed25519 -C "$SSH_PASSPHRASE"

    info "Adding ssh key to keychain"
    ssh-add -K ~/.ssh/id_ed25519

    info "Remember add ssh key to github account 'pbcopy < ~/.ssh/id_ed25519.pub'"
  fi
}

stow_dotfiles() {
  local files=(
    ".aliases"
    ".gitconfig"
    ".jq"
    ".profile*"
    ".vimrc"
    ".zshrc"
    ".zshenv"
  )
  local folders=(
    ".config/fd"
    ".config/git"
    ".config/lf"
    ".config/nvim"
    ".config/ripgrep"
    ".config/vim"
    ".config/wezterm"
  )
  info "Removing existing config files"
  for f in "${files[@]}"; do
    rm -f "$HOME/$f" || true
  done

  # Create the folders to avoid symlinking folders
  for d in "${folders[@]}"; do
    rm -rf "${HOME:?}/$d" || true
    mkdir -p "$HOME/$d"
  done

  # shellcheck disable=SC2155
  local to_stow="$(find stow -maxdepth 1 -type d -mindepth 1 | awk -F "/" '{print $NF}' ORS=' ')"
  local to_stow=${to_stow%?} # remove trailing space
  info "Stowing: $to_stow"
  stow -d stow --verbose 1 --target ${HOME} ${to_stow}

  # set permissions
  chmod a+x ~/.config/git/templates/hooks/pre-commit
}
