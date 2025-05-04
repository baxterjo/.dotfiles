install_rust_tools() {


  rustup default stable
  rustup-init -y

  source $HOME/.cargo/env

  local cargo_packages=(
    'cargo-audit --features=fix'
    cargo-edit
    cargo-expand
    cargo-llvm-cov
    cargo-nextest
  )

  for p in "${cargo_packages[@]}"; do
    info "Installing <cargo ${p//[\"\']}>"
    cargo install ${p//[\"\']}
  done

  local rustup_components=(
    rustfmt
    clippy
  )

  for p in "${rustup_components[@]}"; do
    info "Installing <rustup $p>"
    rustup component add "$p"
  done
}

