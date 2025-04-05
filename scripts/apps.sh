install_macos_apps() {
  local apps=(
    firefox
    google-chrome
    spotify
    wezterm               # https://wezfurlong.org/wezterm
    unnaturalscrollwheels # Reverse scrolling for scroll wheels vs track pads.
    betterdisplay         # More control over display settings.
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
