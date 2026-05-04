install_apps() {
  local apps=(
    betterdisplay # More control over display settings.
    docker
    firefox
    font-meslo-lg-nerd-font
    google-chrome
    keycastr
    postman
    scroll-reverser # Reverse scrolling for scroll wheels vs track pads.
    tidal
    wezterm # https://wezfurlong.org/wezterm
    wireshark
  )

  info "Installing casks..."
  install_brew_casks "${apps[@]}"
}
