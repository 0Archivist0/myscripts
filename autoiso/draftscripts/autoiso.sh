#!/bin/bash

# This is a draft script

# Install required packages
sudo apt-get update
sudo apt-get install -y xorriso isolinux squashfs-tools

# Create a working directory
mkdir -p ~/iso-files
cd ~/iso-files

# Download the Ubuntu minimal ISO image
wget http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso

# Mount the ISO image
sudo mount -o loop mini.iso /mnt

# Copy the contents of the ISO to a working directory
rsync -av /mnt/ ~/iso-files/

# Unmount the ISO image
sudo umount /mnt

# Remove the unnecessary files and folders
sudo rm -rf ~/iso-files/pool/
sudo rm -rf ~/iso-files/dists/
sudo rm -rf ~/iso-files/preseed/
sudo rm -rf ~/iso-files/README*
sudo rm -rf ~/iso-files/index.*
sudo rm -rf ~/iso-files/md5sum*

# Remove desktop environment and unnecessary packages
sudo sed -i 's/deb http:\/\/archive.ubuntu.com\/ubuntu\/ focal main restricted/deb http:\/\/archive.ubuntu.com\/ubuntu\/ focal main restricted universe multiverse/g' ~/iso-files/etc/apt/sources.list
sudo chroot ~/iso-files apt-get update
sudo chroot ~/iso-files apt-get -y remove --purge ubuntu-desktop
sudo chroot ~/iso-files apt-get -y autoremove
sudo chroot ~/iso-files apt-get clean

# Add a Bash script to the ISO
echo '#!/bin/bash

FILEPATH="/custom-script.sh"
if [ -f "$FILEPATH" ]; then
    echo "File $FILEPATH exists, running."
    bash "$FILEPATH"
else
    echo "File $FILEPATH does not exist."
    exec bash
fi' | sudo tee ~/iso-files/custom-script.sh

# Make the Bash script executable
sudo chmod +x ~/iso-files/custom-script.sh

# Create the new ISO image
sudo genisoimage -r -V "Custom Ubuntu" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o custom-ubuntu.iso ~/iso-files/

# Clean up
sudo rm -rf ~/iso-files

# Output the ISO file location
echo "ISO file created at: $(pwd)/custom-ubuntu.iso"
