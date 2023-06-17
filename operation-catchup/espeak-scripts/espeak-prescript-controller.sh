#!/bin/bash

# Define the variables
espeak_xchecker_script=$1
espeak_auto_install_script=$2

# Check if the espeak-xchecker script exists
if [ -f "$espeak_xchecker_script" ]; then
  # Run the espeak-xchecker script
  echo "Running espeak-xchecker script..."
  $espeak_xchecker_script
else
  # The espeak-xchecker script does not exist
  echo "espeak-xchecker script does not exist."
fi

# Check if the espeak-auto-install script exists
if [ -f "$espeak_auto_install_script" ]; then
  # Run the espeak-auto-install script
  echo "Running espeak-auto-install script..."
  $espeak_auto_install_script
else
  # The espeak-auto-install script does not exist
  echo "espeak-auto-install script does not exist."
fi
