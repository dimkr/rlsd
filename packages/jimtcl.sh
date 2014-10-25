PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="http://repo.or.cz/w/jimtcl.git/snapshot/HEAD.tar.gz,jimtcl-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A small Tcl interpreter"

build() {
	[ -d jimtcl ] && rm -rf jimtcl
	tar -xzvf jimtcl-$PACKAGE_VERSION.tar.gz
	cd jimtcl

	patch -p 1 < "$BASE_DIR/patches/jimtcl-doc.patch"

	./configure --host=$HOST \
	            --prefix="/usr" \
	            --bindir="/bin" \
	            --libdir="/lib" \
	            --ipv6 \
	            --disable-jim-regexp
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/jimtcl/README"
	install -m 644 AUTHORS "$1/usr/share/doc/jimtcl/AUTHORS"
	install -m 644 LICENSE "$1/usr/share/doc/jimtcl/LICENSE"
	install -m 644 tcl.license.terms "$1/usr/share/doc/jimtcl/tcl.license.terms"
}
