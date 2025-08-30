#!/usr/bin/env bash

input() {
  prompt=$1
  input=""
  read -p "$prompt" input
  echo "$input"
}

clone() {
    repo_name="nix-config"
    repo_url="https://github.com/samiuens/$repo_name.git"
    
    echo ""

    # check if repo already exists
    if [ -d "$HOME/$repo_name/" ]; then
      echo "git repo already exists."
      return 0
    fi

    echo "> setting up git repo..."
    if [ "$(uname)" == "Darwin" ]; then
        nix shell nixpkgs#git --command git clone $repo_url ~/$repo_name
    elif [ -f /etc/NIXOS ]; then
        git clone $repo_url ~/$repo_name
    fi
    echo "cloned repo into home directory (under ~/$repo_name)"
    cd ~/$repo_name
}

if [ "$(uname)" == "Darwin" ]; then
  echo "> macos detected..."
  echo ""
  echo "this script will prepare the system for nix-darwin installation."
  
  # wait for confirmation
  echo ""
  read -n 1 -s -r -p "[?] press any key to continue or ctrl+c to abort..."
  
  # command line tools
  echo ""
  echo "installing 'command line tools'."
  if [[ -e /Library/Developer/CommandLineTools/usr/bin/git ]]; then
    echo "'command line tools' already installed."
  else
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    softwareupdate -i "$PROD" --verbose
    echo "successfully installed 'command line tools'".
  fi

  # rosetta
  echo ""
  echo "installing 'rosetta'."
  softwareupdate --install-rosetta --agree-to-license
  echo "successfully installed 'rosetta'".

  # determinate nix
  echo ""
  echo "installing nix..."
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm
  
  # clone git repository
  clone

  # complete
  echo ""
  echo "a shell restart is needed."
  echo "after that, run the following command to activate the nix configuration:"
  echo "sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#"
  echo "enter the hostname corresponding to the config you want to apply."
  echo ""

elif [ -f /etc/NIXOS ]; then
  echo "> nixos detected..."
  echo ""
  echo "this script will apply the nix configuration to your system."

  # wait for confirmation
  echo ""
  read -n 1 -s -r -p "[?] press any key to continue or ctrl+c to abort..."

  # clone git repository
  clone

  echo ""
  hostname=$(input "> please provide the hostname, corresponding to the config you want to apply: ")

  echo ""
  echo "> reading nix configuration..."
  if [ ! -d "./hosts/$hostname" ]; then
    echo "[!] no configuration found for $hostname in this repo."
    exit 1
  fi
  echo "found nix configuration."
 
  # copying hardware configuration
  echo ""
  echo "> generating hardware config..."
  sudo rm -rf ./hosts/$hostname/hardware-configuration.nix
  sudo nixos-generate-config --dir ./hosts/$hostname
  echo "generated hardware configuration and copied into repo."

  # generate secure boot keys
  echo ""
  confirm_sb=$(input "[?] are you planning to use 'secure boot' on this system (y/n): ")
  
  if [ $confirm_sb = "y" ]; then
    echo "> using 'secure boot'; generating keys..."
    sudo nix-shell -p sbctl --command "sbctl create-keys" 
    echo ""
    echo "generated secure boot keys."
  else
    echo "> NOT using 'secure boot'"
  fi
  
  echo ""
  sudo nixos-rebuild switch --flake ".#$hostname"
else
  echo ""
  echo "[!] this os is not supported by this configuration."
  echo ""
fi