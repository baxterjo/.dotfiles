install_macos_apps() {
  local apps=(
    betterdisplay         # More control over display settings.
    firefox
    google-chrome
    spotify
    unnaturalscrollwheels # Reverse scrolling for scroll wheels vs track pads.
    wezterm               # https://wezfurlong.org/wezterm
    wireshark
  )

  info "Installing macOS apps..."
  install_brew_casks "${apps[@]}"
}

install_masApps() {
  local apps=(
  )

  info "Installing App Store apps..."
  for app in "${apps[@]}"; do
    mas install "$app"
  done
}
