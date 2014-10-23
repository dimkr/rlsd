PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/orlp/ed25519/archive/master.zip,ed25519-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A digital signature system"

ed25519_build() {
	[ -d ed25519-master ] && rm -rf ed25519-master
	unzip ed25519-$PACKAGE_VERSION.zip
	cd ed25519-master

	patch -p 1 < "$BASE_DIR/patches/ed25519-build.patch"

	cd src
	$MAKE
}

ed25519_package() {
	install -D -m 644 libed25519.a "$1/lib/libed25519.a"
	install -D -m 644 ed25519.h "$1/usr/include/ed25519.h"
	install -D -m 644 ../readme.md "$1/usr/share/doc/ed25519/doc/readme.md"
}
