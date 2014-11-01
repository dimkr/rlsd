PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES=""
PACKAGE_DESC="The file system skeleton"
PACKAGE_ARCH="all"

build() {
	:
}

package() {
	install -D -m 644 "$BASE_DIR/README" "$1/usr/share/doc/rlsd/README"
	install -m 644 "$BASE_DIR/MANIFEST" "$1/usr/share/doc/rlsd/MANIFEST"
	install -m 644 "$BASE_DIR/AUTHORS" "$1/usr/share/doc/rlsd/AUTHORS"
	install -m 644 "$BASE_DIR/THANKS" "$1/usr/share/doc/rlsd/THANKS"
	install -m 644 "$BASE_DIR/COPYING" "$1/usr/share/doc/rlsd/COPYING"
}
