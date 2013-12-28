PACKAGE_VERSION="3.16"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/elilo/elilo/elilo-$PACKAGE_VERSION/elilo-$PACKAGE_VERSION-all.tar.gz"

elilo_build() {
	[ -d elilo-$PACKAGE_VERSION-source ] && rm -rf elilo-$PACKAGE_VERSION-source
	[ -f elilo-$PACKAGE_VERSION-source.tar.gz ] && rm -rf elilo-$PACKAGE_VERSION-source.tar.gz
	tar -xzvf elilo-$PACKAGE_VERSION-all.tar.gz
	tar -xzvf elilo-$PACKAGE_VERSION-source.tar.gz
	cd elilo-$PACKAGE_VERSION-source

	sed -e s~'^EFIINC\t   = /usr/include/efi$'~"EFIINC	   = $SYSROOT/usr/include/efi"~ \
	    -e s~'^GNUEFILIB  = /usr/lib$'~"GNUEFILIB  = $SYSROOT/lib"~ \
	    -e s~'^EFILIB\t   = /usr/lib$'~"EFILIB	   = $SYSROOT/lib"~ \
	    -e s~'^EFICRT0\t   = /usr/lib$'~"EFICRT0	   = $SYSROOT/lib"~ \
	    -e s~'-fno-stack-protector'~'-DGNU_EFI_USE_MS_ABI &'~ \
	    -i Make.defaults

	$MAKE CC="$CC"
}

elilo_package() {
	for i in *.efi
	do
		install -D -m 644 $i "$1/boot/$i"
	done
	install -D -m 644 README "$1/usr/share/doc/elilo/README"
	install -m 644 docs/elilo.txt "$1/usr/share/doc/elilo/elilo.txt"
	install -m 644 ChangeLog "$1/usr/share/doc/elilo/ChangeLog"
}
