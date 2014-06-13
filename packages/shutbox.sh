PACKAGE_VERSION="0.4"
PACKAGE_SOURCES="http://sourceforge.net/projects/shutthebox/files/shutthebox/$PACKAGE_VERSION/shutbox-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A dice ame"

shutbox_build() {
	[ -d shutbox-$PACKAGE_VERSION ] && rm -rf shutbox-$PACKAGE_VERSION
	tar -xzvf shutbox-$PACKAGE_VERSION.tar.gz
	cd shutbox-$PACKAGE_VERSION

        $CC -Dg_signal_connect=gtk_signal_connect \
	    $CFLAGS $(gtk-config --cflags) \
            shutbox.c \
            $LDFLAGS $(gtk-config --libs) \
            -o shutbox
}

shutbox_package() {
	install -D -m 755 shutbox "$1/bin/shutbox"
	install -D -m 644 data/gnome-die1.xpm "$1/usr/share/pixmaps/shutbox.xpm"
	install -D -m 644 README "$1/usr/share/doc/shutbox/README"
	install -m 644 COPYING "$1/usr/share/doc/shutbox/COPYING"
}
