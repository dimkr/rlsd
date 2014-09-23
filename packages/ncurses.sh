PACKAGE_VERSION="5.9"
PACKAGE_SOURCES="http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A terminal handling library"

ncurses_build() {
	[ -d ncurses-$PACKAGE_VERSION ] && rm -rf ncurses-$PACKAGE_VERSION
	tar -xzvf ncurses-$PACKAGE_VERSION.tar.gz
	cd ncurses-$PACKAGE_VERSION

	# force the installation of pkg-config files
	patch -p 1 < "$BASE_DIR/patches/ncurses-pkg-config.patch"

	# building with "--enable-glob" fails against musl 0.9.12
	if [ 1 -eq $STATIC ]
	then
		library_flags="--without-shared --with-normal"
	else
		library_flags="--with-shared --without-normal"
	fi
	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --includedir=/usr/include \
	            --mandir=/usr/share/man \
	            --without-cxx \
	            --without-cxx-binding \
	            --without-ada \
	            --without-progs \
	            --without-tests \
	            --enable-pc-files \
	            --without-libtool \
	            $library_flags \
	            --without-debug \
	            --without-profile \
	            --enable-widec \
	            --with-manpage-format=normal
	$MAKE
}

ncurses_package() {
	$MAKE DESTDIR="$1" install
	mv "$1/usr/lib/pkgconfig" "$1/lib/"
	rmdir "$1/usr/lib"
	ln -s libncurses.a "$1/lib/libtinfo.a"

	# create links for backwards-compatibility
	for i in "$1/lib"/*w.* "$1/lib/pkgconfig"/*w.pc
	do
		name="$(basename "$i")"
		directory="$(dirname "$i")"
		ln -s "$name" "$directory/$(echo "$name" | sed s~w\.~.~)"
	done
	ln -s ncursesw5-config "$1/bin/ncurses5-config"

	# trim the terminfo directory
	rm -rf "$1/usr/share/terminfo/1" \
	       "$1/usr/share/terminfo/2" \
	       "$1/usr/share/terminfo/3" \
	       "$1/usr/share/terminfo/4" \
	       "$1/usr/share/terminfo/5" \
	       "$1/usr/share/terminfo/6" \
	       "$1/usr/share/terminfo/7" \
	       "$1/usr/share/terminfo/8" \
	       "$1/usr/share/terminfo/9" \
	       "$1/usr/share/terminfo/A" \
	       "$1/usr/share/terminfo/E" \
	       "$1/usr/share/terminfo/L" \
	       "$1/usr/share/terminfo/M" \
	       "$1/usr/share/terminfo/N" \
	       "$1/usr/share/terminfo/P" \
	       "$1/usr/share/terminfo/Q" \
	       "$1/usr/share/terminfo/X" \
	       "$1/usr/share/terminfo/a" \
	       "$1/usr/share/terminfo/b" \
	       "$1/usr/share/terminfo/c" \
	       "$1/usr/share/terminfo/d" \
	       "$1/usr/share/terminfo/e" \
	       "$1/usr/share/terminfo/f" \
	       "$1/usr/share/terminfo/g" \
	       "$1/usr/share/terminfo/h" \
	       "$1/usr/share/terminfo/i" \
	       "$1/usr/share/terminfo/j" \
	       "$1/usr/share/terminfo/k" \
	       "$1/usr/share/terminfo/e" \
	       "$1/usr/share/terminfo/m" \
	       "$1/usr/share/terminfo/n" \
	       "$1/usr/share/terminfo/o" \
	       "$1/usr/share/terminfo/p" \
	       "$1/usr/share/terminfo/q" \
	       "$1/usr/share/terminfo/t" \
	       "$1/usr/share/terminfo/u" \
	       "$1/usr/share/terminfo/w" \
	       "$1/usr/share/terminfo/z"
	for i in "$1/usr/share/terminfo/s"/*
	do
		case "$i" in
			*screen*)
				;;
			*)
				rm -f "$i"
				;;
		esac
	done

	for i in "$1/usr/share/terminfo/r"/*
	do
		case "$i" in
			*rxvt*)
				;;
			*)
				rm -f "$i"
				;;
		esac
	done

	for i in "$1/usr/share/terminfo/v"/*
	do
		case "$i" in
			*vt[0-9]*)
				;;
			*)
				rm -f "$i"
				;;
		esac
	done

	for i in "$1/usr/share/terminfo/l"/*
	do
		case "$i" in
			*linux*)
				;;
			*)
				rm -f "$i"
				;;
		esac
	done

	for i in "$1/usr/share/terminfo/x"/*
	do
		case "$i" in
			*xterm*)
				;;
			*)
				rm -f "$i"
				;;
		esac
	done

	install -D -m 644 README "$1/usr/share/doc/ncurses/README"
	install -D -m 644 NEWS "$1/usr/share/doc/ncurses/NEWS"
	install -D -m 644 ANNOUNCE "$1/usr/share/doc/ncurses/ANNOUNCE"
	install -D -m 644 AUTHORS "$1/usr/share/doc/ncurses/AUTHORS"
}
