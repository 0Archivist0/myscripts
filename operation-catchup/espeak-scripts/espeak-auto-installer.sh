#!/bin/bash

# Function to install package based on Debian version and desktop environment
install_package() {
    local package=$1

    case $debian_version in
        "Debian")
            case $desktop_environment in
                "KDE")
                    read -p "Do you want to install $package? (y/n) " choice
                    if [[ $choice =~ ^[Yy]$ ]]; then
                        sudo apt-get install $package -y
                        if [ $? -ne 0 ]; then
                            echo "Failed to install $package. Please try again."
                        fi
                    else
                        echo "Skipping installation of $package."
                    fi
                    ;;
                *)
                    echo "Unsupported desktop environment: $desktop_environment. Unable to install $package."
                    ;;
            esac
            ;;
        *)
            echo "Unsupported Debian version: $debian_version. Unable to install $package."
            ;;
    esac
}

# Function to try to install the specified package. If the installation fails,
# the function will print a message and then skip the installation of the package.
function try_install() {
    local dependency=$1

    install_package "$dependency"
}

# Update the system
update_system() {
    if ! ping -c 1 google.com >/dev/null 2>&1; then
        echo "You are not connected to the internet. Please connect and try again."
        exit 1
    fi

    read -p "Do you want to update the system? (y/n) " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        sudo apt-get update && sudo apt-get upgrade -y
        if [ $? -ne 0 ]; then
            echo "Failed to update the system. Please check your internet connection and try again."
            exit 1
        fi
    else
        echo "Skipping system update."
    fi
}

# Check the Debian version
debian_version=$(lsb_release -d | awk '{print $2}')

# Check the desktop environment
desktop_environment=$(cat /etc/X11/default-display-manager | awk '{print $NF}')

# ... Rest of your script ...

# Check if espeak is installed
if ! command -v espeak >/dev/null 2>&1; then
    read -p "espeak is not installed. Do you want to install it? (y/n) " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        sudo apt-get install espeak -y
        if [ $? -ne 0 ]; then
            echo "Failed to install espeak. Please check your internet connection and try again."
            exit 1
        fi
    else
        echo "Skipping installation of espeak."
    fi
else
    echo "espeak is already installed."
fi

# Check espeak dependencies
dependencies=("libespeak1" "libespeak-dev")
missing_dependencies=()

for dependency in "${dependencies[@]}"; do
    if ! dpkg -s "$dependency" >/dev/null 2>&1; then
        missing_dependencies+=("$dependency")
    fi
done

if [ ${#missing_dependencies[@]} -gt 0 ]; then
    echo "espeak dependencies are missing or not up to date."
    for dependency in "${missing_dependencies[@]}"; do
        try_install "$dependency"
    done
else
    echo "espeak and its dependencies are installed and up to date."
fi

# Update the system
update_system
