#!/usr/bin/env bash

set -eou pipefail

# Usage:
#   ./test_linux.sh         - Run full install test from a remote branch
#   ./test_linux.sh --live  - Run bootstrap only and drop into interactive shell

BASE_IMAGE="kalilinux/kali-rolling:latest"
CONTAINER_NAME="test-linux-dotfile-install"
LIVE_MODE=false

# Parse arguments
if [ "${1:-}" = "--live" ]; then
  LIVE_MODE=true
fi

# Cleanup function to stop and remove container
cleanup() {
  echo "Cleaning up container..."
  docker stop "$CONTAINER_NAME" 2>/dev/null || true
}

# Ensure cleanup runs on exit (success or failure)
trap cleanup EXIT

if [ "$LIVE_MODE" = true ]; then
  # Run the container mounting the current directory to the container.
  docker run --rm -v "$(pwd)":"$(pwd)" -w "$(pwd)" -td --name="$CONTAINER_NAME" "$BASE_IMAGE"

  # Bootstrap the container to install necessary tools to run install.sh
  docker exec -it "$CONTAINER_NAME" bash -c "source ./dotfiles bootstrap"

  # Attempt to run install.sh, drop into shell if it fails.
  docker exec \
    -e IN_CONTAINER=true \
    -e REPO_BRANCH="$(git rev-parse --abbrev-ref HEAD)" \
    -it \
    "$CONTAINER_NAME" bash -c "$(pwd)/install.sh || true"

else
  REPO_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

  # Run the container fresh
  docker run \
    --rm \
    -td \
    -e IN_CONTAINER=true \
    -e REPO_BRANCH="$REPO_BRANCH" \
    --name="$CONTAINER_NAME" "$BASE_IMAGE"

  # Install curl, necesarry for /dotfiles
  docker exec \
    -it \
    "$CONTAINER_NAME" sh -c "apt-get update && apt-get -y install sudo curl"

  # Run the full install script (including git clone) from scratch.
  docker exec \
    -it \
    "$CONTAINER_NAME" \
    bash \
    -c "curl \
    --proto '=https' \
    --tlsv1.2 \
    -fsSL \
    https://raw.githubusercontent.com/baxterjo/.dotfiles/$REPO_BRANCH/dotfiles \
    | bash\
    "
fi
