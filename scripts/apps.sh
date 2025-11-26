install_apps() {
  local generic_apps=(
    font-meslo-lg-nerd-font
  )

  local mac_apps=(
    betterdisplay # More control over display settings.
    firefox
    google-chrome
    keycastr
    postman
    unnaturalscrollwheels # Reverse scrolling for scroll wheels vs track pads.
    tidal
    wezterm # https://wezfurlong.org/wezterm
    wireshark
  )

  info "Installing generic casks..."
  install_brew_casks "${generic_apps[@]}"

  if [[ "$ID_LIKE" == "debian" ]]; then
    info "No linux specific casks to install"
    info "Installing linux apps..."
    install_linux_apps
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    info "Installing mac casks..."
    install_brew_casks "${mac_apps[@]}"
  else
    echo "${OSTYPE} not supported."
    exit 1
  fi
}

# These are apps that cannot be installed on linux via homebrew.
# Always prefer hombrew when adding applications to the apps list
# Order of priority for installing apps should be:
# 1. Homebrew
# 2. apt / apt-get
# 3. Manual installation
install_linux_apps() {

  # Add APT repositories.
  # All commands are taken straight from installation instructions of given application.
  info "Installing software-properties-common"
  sudo apt install -y software-properties-common python3-launchpadlib

  # Firefox
  info "Adding Firefox apt repository"
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc >/dev/null
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list >/dev/null

  # Wezterm
  info "Adding Wezterm apt repository"
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

  # Update apt after adding repositories
  sudo apt update
  sudo apt-get update

  # Install apps
  info "Installing Firefox"
  sudo apt-get install -y firefox

  info "Installing Wezterm"
  sudo apt install -y wezterm

  info "Installing Wireshark"
  # This ensures wireshark does not prompt to allow non-sudo users to conduct captures.
  echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
  sudo apt install -y wireshark

}
