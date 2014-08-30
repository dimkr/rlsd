PACKAGE_VERSION="0.5"
PACKAGE_SOURCES="https://www.kernel.org/pub/software/network/rfkill/rfkill-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="A tool for disabling network interfaces"

rfkill_build() {
	[ -d rfkill-$PACKAGE_VERSION ] && rm -rf rfkill-$PACKAGE_VERSION
	tar -xJvf rfkill-$PACKAGE_VERSION.tar.xz
	cd rfkill-$PACKAGE_VERSION

	$MAKE
}

rfkill_package() {
	$MAKE DESTDIR="$1" SBINDIR="/bin" install
	install -D -m 644 README "$1/usr/share/doc/rfkill/README"
	install -m 644 COPYING "$1/usr/share/doc/rfkill/COPYING"
}
