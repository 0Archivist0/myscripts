#!/bin/bash

# Check if the PPA is in the sources list, and add it if not present
if ! grep -q "ppa:neon/stable" /etc/apt/sources.list; then
  echo "The ppa:neon/stable PPA is not in your sources list. Adding it now..."
  sudo add-apt-repository ppa:neon/stable
fi

# Update the sources list
sudo apt update

# Install the kspeechtotext package
sudo apt install kspeechtotext

# Check if the kspeechtotext package was installed successfully
if [ -f "/usr/bin/kspeechtotext" ]; then
  echo "kspeechtotext package was installed successfully."
else
  echo "kspeechtotext package was not installed successfully."
fi
