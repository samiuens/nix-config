# Default entry method
default:
  just help

# Deploy changes from nix configuration to local machine
deploy method='switch':
  #!/usr/bin/env sh
  if [ "$(uname)" == "Darwin" ]; then
    sudo darwin-rebuild {{method}} --flake ".#" --show-trace
  else
    sudo nixos-rebuild {{method}} --flake ".#" --show-trace
  fi

# Update nix flakes
up:
  nix flake update

# Switch to nix configurations directory
cd:
  cd .

# Opens nix configuration in vscode
code:
  code .

# Opens nix configuration in vscodium
codium:
  codium .

# Choose a linting operation
lint method='help':
  statix {{method}}

# Get help
help:
  just --list