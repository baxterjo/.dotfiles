install_apps() {
  local generic_apps=(
    font-meslo-lg-nerd-font
  )

  local mac_apps=(
    betterdisplay         # More control over display settings.
    firefox
    google-chrome
    keycastr
    postman
    spotify
    unnaturalscrollwheels # Reverse scrolling for scroll wheels vs track pads.
    wezterm               # https://wezfurlong.org/wezterm
    wireshark
  )

  info "Installing generic casks..."
  install_brew_casks "${generic_apps[@]}"

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    info "No linux specific casks to install"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    info "Installing mac casks..."
    install_brew_casks "${mac_apps[@]}"
  else
    echo "${OSTYPE} not supported."
    exit 1
  fi
}

