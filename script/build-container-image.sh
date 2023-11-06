#!/bin/bash

set -e

mkdir rootfs
losetup -f vyos-rolling-latest.iso
mount_point=$(losetup -j vyos-rolling-latest.iso | cut -d : -f 1)
mount -t iso9660 $mount_point rootfs/

mkdir unsquashfs
unsquashfs -f -d unsquashfs/ rootfs/live/filesystem.squashfs

cp file/vyos-postconfig-bootup.script unsquashfs/opt/vyatta/etc/config/scripts/vyos-postconfig-bootup.script

sed -i 's/^LANG=.*$/LANG=C.UTF-8/' unsquashfs/etc/default/locale

rm -rf unsquashfs/boot/*.img
rm -rf unsquashfs/boot/*vyos*
rm -rf unsquashfs/boot/vmlinuz
rm -rf unsquashfs/lib/firmware/
rm -rf unsquashfs/usr/lib/x86_64-linux-gnu/libwireshark.so*
rm -rf unsquashfs/lib/modules/*amd64-vyos

rm -rf unsquashfs/config
ln -s /opt/vyatta/etc/config unsquashfs/
