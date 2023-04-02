#!/bin/bash

# Set variables
ISO_NAME="my_bootable_image.iso"
MOUNT_DIR="/mnt/iso"
ISO_DIR="/tmp/iso"
SCRIPT_NAME="my_script.sh"
FILEPATH="/path/to/myfile.txt"

# Install dependencies
apt-get update
apt-get install -y xorriso

# Download Ubuntu minimal image
wget http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso -O ${ISO_NAME}

# Mount the ISO
mkdir -p ${MOUNT_DIR}
mount -o loop ${ISO_NAME} ${MOUNT_DIR}

# Copy ISO contents to working directory
rsync -a ${MOUNT_DIR}/ ${ISO_DIR}/

# Unmount ISO
umount ${MOUNT_DIR}

# Remove unneeded files
rm -rf ${ISO_DIR}/pool
rm -rf ${ISO_DIR}/dists
rm -rf ${ISO_DIR}/pics
rm -rf ${ISO_DIR}/README*
rm -rf ${ISO_DIR}/index.*

# Add Bash script to ISO
cp ${SCRIPT_NAME} ${ISO_DIR}/boot/

# Add custom boot options to ISO
cat << EOF > ${ISO_DIR}/boot/grub/custom.cfg
menuentry "My Custom ISO" {
    linux /boot/vmlinuz
    initrd /boot/initrd
    boot
}
EOF

# Build ISO image
xorriso -as mkisofs -iso-level 3 -full-iso9660-filenames -volid "My Custom ISO" \
  -eltorito-boot boot/grub/grub.img -eltorito-catalog boot/grub/boot.cat \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -output ${ISO_NAME} ${ISO_DIR}

# Clean up
rm -rf ${ISO_DIR}

# Print success message
echo "Bootable ISO image ${ISO_NAME} created successfully."

# Test file existence and run script or open Bash
if [ -f ${FILEPATH} ]; then
    echo "File ${FILEPATH} exists, running."
    bash ${FILEPATH}
else
    echo "File ${FILEPATH} doesn't exist."
    bash
fi
