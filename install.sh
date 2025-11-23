#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

. scripts/utils.sh
. scripts/brew.sh
. scripts/apps.sh
. scripts/cli.sh
. scripts/config.sh
. scripts/osx.sh
. scripts/packages.sh

cleanup() {
  info "Finishing..."
}

wait_input() {
  # This condition checks if STDIN is connected to a terminal.
  # Also known as "interactive mode"
  if [ -t 0 ]; then
    read -r -p "Press enter to continue: "
  fi
}

main() {
  info "Dotfiles setup"

  info "################################################################################"
  info "Homebrew Packages"
  info "################################################################################"
  wait_input
  install_packages

  success "Finished installing Homebrew packages"

  info "################################################################################"
  info "Cask Apps"
  info "################################################################################"
  wait_input
  install_apps

  info "################################################################################"
  info "Rust tools"
  info "################################################################################"
  wait_input
  install_rust_tools
  success "Finished installing Rust tools"

  info "################################################################################"
  info "Configuration"
  info "################################################################################"
  wait_input

  if [[ "$OSTYPE" == "darwin"* ]]; then
    setup_osx
    success "Finished configuring MacOS defaults. NOTE: A restart is needed"
  fi

  stow_dotfiles
  success "Finished stowing dotfiles"

  info "################################################################################"
  info "SSH Key"
  info "################################################################################"
  setup_github_ssh
  success "Finished setting up SSH Key"

  success "Done"

  info "System needs to restart. Restart?"

  select yn in "y" "n"; do
    case $yn in
    y)
      sudo shutdown -r now
      break
      ;;
    n) exit ;;
    esac
  done
}

trap cleanup SIGINT SIGTERM ERR EXIT

main
