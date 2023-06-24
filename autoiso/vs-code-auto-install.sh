#!/bin/bash

# This script installs Visual Studio Code on a Linux system.

# Check if VS Code is already installed.
is_vscode_installed() {
  if [ -x "$(command -v code)" ]; then
    return 0
  else
    return 1
  fi
}

# Install VS Code.
install_vscode() {
  echo "Installing Visual Studio Code..."
  curl -o vscode.deb -L https://go.microsoft.com/fwlink/?LinkID=760868
  if [ $? -eq 0 ]; then
    sudo dpkg -i vscode.deb
    sudo apt install -f
    sudo apt-get autoremove
    rm vscode.deb
    echo "Visual Studio Code has been installed."
  else
    echo "Failed to download Visual Studio Code. Installation aborted."
    exit 1
  fi
}

# Main script.
if is_vscode_installed; then
  echo "Visual Studio Code is already installed."
else
  install_vscode
fi
