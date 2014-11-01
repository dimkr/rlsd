PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES=""
PACKAGE_DEPS=""
PACKAGE_DESC="The initial file system archive"

# files present in the initramfs
INITRAMFS_FILES="bin/toybox
                 bin/init
                 bin/ksh
                 bin/awk
                 bin/syslogd
                 bin/klogd
                 bin/mkdir
                 bin/cp
                 bin/chroot
                 bin/cttyhack
                 bin/grep
                 bin/losetup
                 bin/mount
                 bin/umount
                 bin/luufs
                 bin/fusermount
                 bin/sleep
                 bin/clear
                 bin/cat
                 bin/contain
                 bin/poweroff
                 bin/reboot
                 bin/setfont
                 usr/share/consolefonts/Tamsyn8x16r.psf"

# directories present in the initramfs
INITRAMFS_DIRECTORIES="run
                       tmp
                       etc/rc.d
                       bin
                       var/log
                       proc
                       dev
                       mnt/home
                       mnt/rw
                       mnt/union
                       mnt/ro
                       sys
                       etc/rc.d
                       usr/share/consolefonts"

build() {
	# create a temporary directory for the initramfs contents
	initramfs_root="$(mktemp -d -u)"

	# create the initramfs directories
	for directory in $INITRAMFS_DIRECTORIES
	do
		mkdir -p "$initramfs_root/$directory"
	done

	# add required programs and scripts to the initramfs
	for i in $INITRAMFS_FILES
	do
		if [ -f "$BASE_DIR/initramfs/$i" ]
		then
			path="$BASE_DIR/initramfs/$i"
		else
			path="$SYSROOT/$i"
		fi
		cp "$path" "$initramfs_root/$i"
	done

	# create /dev/console
	mknod -m 622 "$initramfs_root/dev/console" c 5 1

	# add startup and shutdown scripts
	echo -n '#!/bin/ksh

# set the executable search path
export PATH="/bin"

# clear the screen from boot loader or early kernel messages
clear

# set the console font
setfont /usr/share/consolefonts/Tamsyn8x16r.psf

# display an ASCII logo
echo "       _         _
  ____| |___  __| |
 |  __| / __|/ _  |
 | |  | \__ \ (_| |
 |_|  |_|___/\__,_|
"

# mount virtual file systems
echo -n "Mounting virtual file systems ..."

mount -t proc proc /proc
mount -t sysfs sys /sys
mount -t devtmpfs dev /dev
mount -t tmpfs -o mode=700,size=5% run /run
mount -t tmpfs -o mode=755,size=20% log /var/log
mount -t tmpfs -o mode=1777,noexec,nosuid,nodev,size=25% tmp /tmp
mkdir /dev/pts
mount -t devpts -o mode=620 pts /dev/pts
mkdir /run/shm /dev/shm
mount -B /run/shm /dev/shm

# if there is at least 256 MB of RAM, copy the root file system image to RAM
if [ 262144 -le $(grep MemTotal: /proc/meminfo | awk "{print \$2}") ]
then
	copy=1
else
	copy=0
fi

# read the kernel command-line
home=""
secure=1
for i in $(cat /proc/cmdline)
do
	case "$i" in
		home=*)
			home="${i#*=}"
			;;
		sleep=*)
			interval="${i#*=}"
			echo -n " done.
Waiting for $interval seconds ..."
			sleep $interval
			;;
		secure=0)
			secure=0
			;;
	esac
done

# start logging daemons
echo -n " done.
Starting logging services ..."

syslogd
klogd

# find the home partition
echo -n " done.
Searching for the home partition ..."
cd /sys/class/block
is_found=0
for i in 1 2 3 4 5 6 7 8 9 10
do
	for partition in sd* mmc* sr*
	do
		mount -o ro /dev/$partition /mnt/home
		if [ 0 -eq $? ]
		then
			if [ -f /mnt/home/boot/bzImage ] &&
			   [ -f /mnt/home/boot/initrd.xz ] &&
			   [ -f /mnt/home/boot/rootfs.sfs ]
			then
				is_found=1
				break 2
			fi
		fi
	done
	sleep 1
done
if [ 0 -eq $is_found ]
then
	echo " failure."
	exit
fi

# copy the root file system image to RAM
if [ 0 -eq $copy ]
then
	image_path="/mnt/home/boot/rootfs.sfs"
else
	echo -n " done.
Copying the root file system to RAM ..."
	cp /mnt/home/boot/rootfs.sfs /rootfs.sfs
	umount /mnt/home
	image_path="/rootfs.sfs"
fi

# mount the root file system image
echo -n " done.
Mounting the root file system ..."
losetup -r /dev/loop0 "$image_path"
mount -t squashfs -o ro /dev/loop0 /mnt/ro

# mount a writable file system
echo -n " done.
Setting up a writable system ..."
if [ -n "$home" ]
then
	mount "/dev/$home" /mnt/rw
else
	mount -t tmpfs save /mnt/rw
fi

# mount a layered file system
echo -n " done.
Setting up a layered file system ..."

luufs -o suid,dev,allow_other,default_permissions /mnt/ro /mnt/rw /mnt/union
mount -B /sys /mnt/union/sys
mount -R /dev /mnt/union/dev
mount -B /run /mnt/union/run
mount -B /mnt/union/run /mnt/union/var/run
mkdir /run/mnt
mount -B /run/mnt /mnt/union/mnt
mount -B /var/log /mnt/union/var/log
mount -B /tmp /mnt/union/tmp

echo " done."

# continue the boot process inside the layered file system, in a container
if [ 0 -eq $secure ]
then
	mount -B /proc /mnt/union/proc
	cttyhack chroot /mnt/union /etc/rc.d/rc.sysinit
else
	cttyhack contain /mnt/union /etc/rc.d/rc.sysinit
	case $? in
		2)
			poweroff
			;;
		*)
			reboot
			;;
	esac
fi' > "$initramfs_root/etc/rc.d/rc.initramfs"
	chmod 755 "$initramfs_root/etc/rc.d/rc.initramfs"

	echo -n '#!/bin/ksh

# unmount the union file system
echo -n "Unmounting the layered file system ..."
umount /mnt/union/mnt
umount /mnt/union/run
umount /mnt/union/var/log
umount /mnt/union/tmp
umount /mnt/union
losetup -d /dev/loop0

# unmount all virtual file systems, except those which cannot be unmounted when
# the RLSD security module is active
echo -n " done.
Unmounting virtual file systems ..."

umount /dev/shm
umount /tmp
umount /var/log
umount /run

# unmount remaining file systems
echo -n " done.
Unmounting remaining file systems ..."
umount -a

echo " done."' > "$initramfs_root/etc/rc.d/rc.shutdown"
	chmod 755 "$initramfs_root/etc/rc.d/rc.shutdown"

	# generate an initramfs archive
	dir="$(pwd)"
	cd "$initramfs_root"
	chown -R 0:0 .
	chmod 1777 tmp
	find . | cpio -o -H newc | xz -9 -e --check=none > "$dir/initrd.xz"
	rm -rf "$initramfs_root"
	cd "$dir"
}

package() {
	install -D -m 644 initrd.xz "$1/boot/initrd.xz"
}
