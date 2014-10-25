PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/packlad/archive/master.zip,packlad-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A package manager"

build() {
	[ -d packlad-master ] && rm -rf packlad-master
	unzip packlad-$PACKAGE_VERSION.zip
	cd packlad-master

	cp /etc/packlad/pub_key keys/
	cp /etc/packlad/priv_key keys/
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
}
