#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -x

. scripts/utils.sh
. scripts/config.sh


stow_dotfiles
success "Finished stowing dotfiles"