PACKAGE_VERSION="0.7.8"
PACKAGE_SOURCES="http://sourceforge.net/projects/refind/files/$PACKAGE_VERSION/refind-src-$PACKAGE_VERSION.zip"

refind_build() {
	[ -d refind-$PACKAGE_VERSION ] && rm -rf refind-$PACKAGE_VERSION
	unzip refind-src-$PACKAGE_VERSION.zip
	cd refind-$PACKAGE_VERSION

	sed -e s~'EFIINC          = /usr/include/efi'~"EFIINC          = $SYSROOT/usr/include/efi"~ \
	    -e s~'GNUEFILIB       = /usr/lib64'~"GNUEFILIB       = $SYSROOT/lib"~ \
	    -e s~'EFILIB          = /usr/lib64'~"EFILIB          = $SYSROOT/lib"~ \
	    -e s~'EFICRT0         = /usr/lib64'~"EFICRT0         = $SYSROOT/lib"~ \
	    -i Make.common

	$MAKE CC="$CC" gnuefi
}

refind_package() {
	if [ -f refind/refind_x64.efi ]
	then
		file_name="refind_x64.efi"
	else
		file_name="refind_ia32.efi"
	fi
	install -D -m 644 refind/$file_name "$1/boot/$file_name"
	install -d -m 755 "$1/usr/share/refind"
	cp -r icons "$1/usr/share/refind"
	install -m 644 refind.conf-sample "$1/boot/refind.conf"
	install -D -m 644 README.txt "$1/usr/share/doc/refind/README.txt"
	install -m 644 NEWS.txt "$1/usr/share/doc/refind/NEWS.txt"
	install -m 644 CREDITS.txt "$1/usr/share/doc/refind/CREDITS.txt"
	install -m 644 COPYING.txt "$1/usr/share/doc/refind/COPYING.txt"
	install -m 644 LICENSE.txt "$1/usr/share/doc/refind/LICENSE.txt"
}
