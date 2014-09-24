PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/xorg62/tty-clock/archive/master.zip,tty-clock-$PACKAGE_VERSION.zip"
PACKAGE_DESC="An analog clock"

tty_clock_build() {
	[ -d tty-clock-master ] && rm -rf tty-clock-master
	unzip tty-clock-$PACKAGE_VERSION.zip
	cd tty-clock-master

	$CC -o tty-clock ttyclock.c $CFLAGS $LDFLAGS -lncurses
}

tty_clock_package() {
	install -D -m 755 tty-clock "$1/bin/tty-clock"
	install -D -m 644 tty-clock.1 "$1/usr/share/man/man1/tty-clock.1"
	install -D -m 644 README "$1/usr/share/doc/tty-clock/README"
	head -n 30 ttyclock.c | tail -n 28 | cut -c 9- > "$1/usr/share/doc/tty-clock/COPYING"
	chmod 644 "$1/usr/share/doc/tty-clock/COPYING"
}
