packages=(
  bat    # https://github.com/sharkdp/bat
  black  # Python code formatter
  bottom # https://github.com/ClementTsang/bottom
  buf
  cmake # https://cmake.org/
  ctags
  curl
  eza       # https://github.com/eza-community/eza
  fd        # https://github.com/sharkdp/fd
  ffmpeg    # https://ffmpeg.org/ - Media manipulator
  figlet    # http://www.figlet.org/ - Normal text to ascii art
  fzf       # https://github.com/junegunn/fzf
  git-delta # https://github.com/dandavison/delta
  gpg
  hyperfine # https://github.com/sharkdp/hyperfine
  imagemagick
  isort
  jq
  # lf         # https://github.com/gokcehan/lf
  llvm
  luarocks # https://luarocks.org/
  mas # https://github.com/mas-cli/mas
  neovim
  nmap
  openssl
  pinentry-mac
  protobuf
  python3
  ripgrep # https://github.com/BurntSushi/ripgre
  rust-analyzer
  rustup
  sd # https://github.com/chmln/sd
  shellcheck
  stow
  stylua
  telnet
  tmux
  wget
  zinit  # https://github.com/zdharma-continuum/zinit
  zoxide # https://github.com/ajeetdsouza/zoxide
)


install_packages() {

  info "Installing homebrew formulae..."
  install_brew_formulas "${packages[@]}"

  info "Cleaning up brew packages..."
  brew cleanup
}
