

packages=(
  bat     # https://github.com/sharkdp/bat
  bottom  # https://github.com/ClementTsang/bottom
  black   # Python code formatter
  ctags
  curl
  eza   # https://github.com/eza-community/eza
  fzf   # https://github.com/junegunn/fzf
  fd # https://github.com/sharkdp/fd
  git-delta # https://github.com/dandavison/delta
  gpg
  imagemagick
  jq
  hyperfine  # https://github.com/sharkdp/hyperfine
  # lf         # https://github.com/gokcehan/lf
  llvm 
  mas # https://github.com/mas-cli/mas
  neovim
  nmap
  openssl
  pinentry-mac
  python3
  protobuf
  ripgrep # https://github.com/BurntSushi/ripgre
  rustup
  sd # https://github.com/chmln/sd
  shellcheck
  stow
  telnet
  tmux
  wget
  zsh
  zinit  # https://github.com/zdharma-continuum/zinit
  zoxide # https://github.com/ajeetdsouza/zoxide
)

install_packages() {

  info "Installing packages..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}
