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
# 3. Snap (if necessary)
# 4. Manual installation
install_linux_apps() {

  # Add APT repositories.
  # All commands are taken straight from installation instructions of given application.
  sudo apt install -y software-properties-common

  # Firefox
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
  echo '
  Package: *
  Pin: origin packages.mozilla.org
  Pin-Priority: 1000
  ' | sudo tee /etc/apt/preferences.d/mozilla

  # Spotify
  curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

  # Wezterm
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

  # Wireshark
  sudo add-apt-repository ppa:wireshark-dev/stable



  # Update apt after adding repositories
  sudo apt update
  sudo apt-get update

  # Install apps
  sudo apt-get install -y firefox
  sudo apt-get install -y spotify-client
  sudo apt install -y wezterm
  sudo apt install -y wireshark
  
  # Snap does not like docker for some reason
  if [ -z ${IN_CONTAINER+x} ]; then
    sudo snap install postman
  fi
}
