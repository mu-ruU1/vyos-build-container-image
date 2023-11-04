#!/bin/bash

set -e

mkdir rootfs
mount -t iso9660 -o loop vyos-rolling-latest.iso rootfs/

mkdir unsquashfs
losetup -a
unsquashfs -f -d unsquashfs/ rootfs/live/filesystem.squashfs

sed -i 's/^LANG=.*$/LANG=C.UTF-8/' unsquashfs/etc/default/locale

rm -rf unsquashfs/boot/*.img
rm -rf unsquashfs/boot/*vyos*
rm -rf unsquashfs/boot/vmlinuz
rm -rf unsquashfs/lib/firmware/
rm -rf unsquashfs/usr/lib/x86_64-linux-gnu/libwireshark.so*
rm -rf unsquashfs/lib/modules/*amd64-vyos

rm -rf unsquashfs/config
ln -s /opt/vyatta/etc/config unsquashfs/
