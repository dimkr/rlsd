PACKAGE_VERSION="15"
PACKAGE_SOURCES="https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-$PACKAGE_VERSION.tar.xz https://raw.github.com/rofl0r/sabotage/master/KEEP/kmod.patch"

kmod_build() {
	[ -d kmod-$PACKAGE_VERSION ] && rm -rf kmod-$PACKAGE_VERSION
	tar -xJf kmod-$PACKAGE_VERSION.tar.xz
	cd kmod-$PACKAGE_VERSION

	# allow building libkmod as a static library; according to the release
	# announcement of kmod 15, static linking was disallowed causes problems for
	# certain packages (https://lwn.net/Articles/564385/)
	sed s~'"x\$enable_static" = "xyes"'~'"x\$enable_static" = "xcrap"'~ \
	    -i configure

	patch -p1 < ../kmod.patch
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --enable-static \
	            --disable-shared \
	            --disable-manpages \
	            --without-bashcompletiondir
	make
}

kmod_package() {
	make DESTDIR="$1" install
	for i in lsmod rmmod insmod modinfo modprobe depmod
	do
		ln -s kmod "$1/bin/$i"
	done
	install -D -m 644 README "$1/usr/share/doc/kmod/README"
	install -D -m 644 NEWS "$1/usr/share/doc/kmod/NEWS"
	install -D -m 644 COPYING "$1/usr/share/doc/kmod/COPYING"
}
