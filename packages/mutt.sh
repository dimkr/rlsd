PACKAGE_VERSION="1.5.23"
PACKAGE_SOURCES="http://sourceforge.net/projects/mutt/files/mutt/mutt-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An e-mail client"

mutt_build() {
	[ -d mutt-$PACKAGE_VERSION ] && rm -rf mutt-$PACKAGE_VERSION
	tar -xzvf mutt-$PACKAGE_VERSION.tar.gz
	cd mutt-$PACKAGE_VERSION

	SENDMAIL="/bin/msmtp" \
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --enable-pop \
	            --enable-imap \
	            --enable-hcache \
	            --disable-nls \
	            --with-ssl
	$MAKE
}

mutt_package() {
	$MAKE DESTDIR="$1" install
}
