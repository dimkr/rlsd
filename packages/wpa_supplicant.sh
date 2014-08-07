PACKAGE_VERSION="2.1"
PACKAGE_SOURCES="http://hostap.epitest.fi/releases/wpa_supplicant-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A tool for association with wireless networks"

wpa_supplicant_build() {
	[ -d wpa_supplicant-$PACKAGE_VERSION ] && rm -rf wpa_supplicant-$PACKAGE_VERSION
	tar -xzvf wpa_supplicant-$PACKAGE_VERSION.tar.gz
	cd wpa_supplicant-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/wpa_supplicant-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/wpa_supplicant-libnl_tiny.patch"

	cd wpa_supplicant
	cp defconfig .config
	echo "CONFIG_TLS=openssl" >> .config
	echo "CONFIG_TLSV11=y" >> .config
	echo "CONFIG_TLSV12=y" >> .config
	echo "CC = $CC" >> .config
	echo "CFLAGS += -D_GNU_SOURCE $(pkg-config --cflags libnl-tiny)" >> .config
	echo "LDFLAGS += $(pkg-config --libs libnl-tiny)" >> .config
	echo "CONFIG_LIBNL_TINY=y" >> .config
	$MAKE CC="$CC"
}

wpa_supplicant_package() {
	$MAKE DESTDIR="$1" BINDIR="/bin" install
	install -D -m 644 README "$1/usr/share/doc/wpa_supplicant/README"
	install -m 644 ../COPYING "$1/usr/share/doc/wpa_supplicant/COPYING"
}
