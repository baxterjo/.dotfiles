generic_packages=(
  bat     # https://github.com/sharkdp/bat
  bottom  # https://github.com/ClementTsang/bottom
  black   # Python code formatter
  buf
  cmake   # https://cmake.org/
  ctags
  curl
  eza   # https://github.com/eza-community/eza
  fd # https://github.com/sharkdp/fd
  ffmpeg
  fzf   # https://github.com/junegunn/fzf
  git-delta # https://github.com/dandavison/delta
  gpg
  imagemagick
  isort
  jq
  hyperfine  # https://github.com/sharkdp/hyperfine
  # lf         # https://github.com/gokcehan/lf
  llvm 
  neovim
  nmap
  openssl
  python3
  protobuf
  ripgrep # https://github.com/BurntSushi/ripgre
  rustup
  rust-analyzer
  sd # https://github.com/chmln/sd
  shellcheck
  stow
  stylua
  tmux
  wget
  zsh
  zinit  # https://github.com/zdharma-continuum/zinit
  zoxide # https://github.com/ajeetdsouza/zoxide
)

mac_packages=(
  pinentry-mac
  mas # https://github.com/mas-cli/mas
  telnet
)

linux_packages=(
  pinentry
)

install_packages() {

  info "Installing generic packages..."
  install_brew_formulas "${generic_packages[@]}"

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    info "Installing linux packages..."
    install_brew_formulas "${linux_packages[@]}"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    info "Installing mac packages..."
    install_brew_formulas "${mac_packages[@]}"
  else
    echo "${OSTYPE} not supported."
    exit 1
  fi

  info "Cleaning up brew packages..."
  brew cleanup
}
