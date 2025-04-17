setup_osx() {
  info "Configuring MacOS default settings"

  # Avoid creating .DS_Store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Show hidden files inside the finder
  defaults write com.apple.finder "AppleShowAllFiles" -bool true

  # Show Status Bar
  defaults write com.apple.finder "ShowStatusBar" -bool true

  # Do not show warning when changing the file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Set search scope to current folder
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  defaults write com.apple.screencapture type -string "png"

  # Set weekly software update checks
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7

  # Set HOME as the default location for new Finder windows
  # For other paths, use `PfLo` and `file:///full/path/here/`
  defaults write com.apple.finder NewWindowTarget -string "PfHm"
  defaults write com.apple.finder NewWindowTargetPath -string "file:///${HOME}/"

  # Set Dock autohide
  defaults write com.apple.dock autohide -bool false
  defaults write com.apple.dock largesize -float 128
  defaults write com.apple.dock "minimize-to-application" -bool true
  defaults write com.apple.dock tilesize -float 40

  # Secondary click in external mouse
  defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string "TwoButton"

  # Disable startup sound
  sudo nvram SystemAudioVolume=%01
}
