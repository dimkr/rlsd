PACKAGE_VERSION="master"
PACKAGE_SOURCES="https://github.com/iguleder/lazy-utils/archive/master.zip,lazy-utils-master.zip"

lazy_utils_build() {
	#[ -d lazy-utils-master ] && rm -rf lazy-utils-master
	#unzip lazy-utils-master.zip
	cd lazy-utils-master

	$CC $CFLAGS $LDFLAGS init.c -o init
	$CC $CFLAGS $LDFLAGS poweroff.c -o poweroff
	$CC $CFLAGS $LDFLAGS reboot.c -o reboot
	$CC $CFLAGS $LDFLAGS mount.c -o mount
	$CC $CFLAGS $LDFLAGS umount.c -o umount
	$CC $CFLAGS $LDFLAGS syslogd.c -o syslogd
	$CC $CFLAGS $LDFLAGS klogd.c -o klogd
	$CC $CFLAGS $LDFLAGS hostname.c -o hostname
	$CC $CFLAGS $LDFLAGS cttyhack.c -o cttyhack
	$CC $CFLAGS $LDFLAGS logger.c -o logger
}

lazy_utils_package() {
	install -D -m 755 init "$1/bin/init"
	ln -s ./bin/init "$1/init"
	install -m 755 poweroff "$1/bin/poweroff"
	install -m 755 reboot "$1/bin/reboot"
	install -m 755 mount "$1/bin/mount"
	install -m 755 umount "$1/bin/umount"
	install -m 755 syslogd "$1/bin/syslogd"
	install -m 755 klogd "$1/bin/klogd"
	install -m 755 hostname "$1/bin/hostname"
	install -m 755 cttyhack "$1/bin/cttyhack"
	install -m 755 logger "$1/bin/logger"
	install -D -m 644 README "$1/usr/share/doc/lazy-utils/README"
	install -m 644 AUTHORS "$1/usr/share/doc/lazy-utils/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/lazy-utils/COPYING"
}
