#!/bin/sh
set -e

./board/raspberrypizero2w-64/post-build.sh

# Configure fstab to mount /boot partition
mkdir -p ${TARGET_DIR}/boot
echo "/dev/mmcblk0p1 /boot vfat defaults 0 2" >> ${TARGET_DIR}/etc/fstab

# Install zicBox
cd ${TARGET_DIR}
mkdir -p opt/zicBox
cd opt/zicBox
rm -rf *
echo "ZICBOX_PATH: $ZICBOX_PATH"
if [ -n "$ZICBOX_PATH" ]; then
    echo "Using local ZICBOX_PATH: $ZICBOX_PATH"
    cp -r "$ZICBOX_PATH"/build/arm/* .
    cp -r "$ZICBOX_PATH"/data ./data
else
    echo "Skipping zicBox download - not available"
fi

## Install filebrowser: web server for file management
#if [ ! -f "${TARGET_DIR}/usr/bin/filebrowser" ]; then
#    cd /tmp
#    wget https://github.com/filebrowser/filebrowser/releases/download/v2.32.0/linux-arm64-filebrowser.tar.gz
#    tar -xzf /tmp/linux-arm64-filebrowser.tar.gz --strip-components=0 -C ${TARGET_DIR}/usr/bin filebrowser
#    rm /tmp/linux-arm64-filebrowser.tar.gz
#else
#    echo "filebrowser already installed."
#fi

mv ${TARGET_DIR}/etc/init.d/S10mdev ${TARGET_DIR}/etc/init.d/S000mdev || true
mv ${TARGET_DIR}/etc/init.d/S05avahi-setup.sh ${TARGET_DIR}/etc/init.d/S35avahi-setup.sh || true

# echo "Adding user 'zic'..."
# # Check if the user already exists to prevent duplication
# if ! grep -q "^zic:" "$TARGET_DIR/etc/passwd"; then
#     # Add the 'zic' group with GID 1000
#     echo "zic:x:1000:" >> "$TARGET_DIR/etc/group"
#     # Add the 'zic' user with UID 1000 and home directory /home/zic
#     echo "zic::1000:1000:Linux User,,,:/home/zic:/bin/sh" >> "$TARGET_DIR/etc/passwd"
#     # Create the home directory and set permissions
#     # mkdir -p "$TARGET_DIR/home/zic"
#     # chown -R 1000:1000 "$TARGET_DIR/home/zic"
#     # chmod 755 "$TARGET_DIR/home/zic"
#     echo "User 'zic' added successfully."
# else
#     echo "User 'zic' already exists."
# fi