#!/bin/bash

# Check if xclip is installed
if command -v xclip >/dev/null; then
    echo "xclip is installed."
else
    echo "xclip is not installed. Would you like to install it?"
    read -p "(y/n) " choice

    if [[ $choice == "y" ]]; then
        sudo apt-get install xclip
    else
        echo "xclip will not be installed."
    fi
fi

# Check if xsel is installed
if command -v xsel >/dev/null; then
    echo "xsel is installed."
else
    echo "xsel is not installed. Would you like to install it?"
    read -p "(y/n) " choice

    if [[ $choice == "y" ]]; then
        sudo apt-get install xsel
    else
        echo "xsel will not be installed."
    fi
fi
