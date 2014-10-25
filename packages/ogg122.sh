PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/ogg122/archive/master.zip,ogg122-$PACKAGE_VERSION.zip"
PACKAGE_DESC="An Ogg Vorbis player"

build() {
	[ -d ogg122-master ] && rm -rf ogg122-master
	unzip ogg122-$PACKAGE_VERSION.zip
	cd ogg122-master

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
}
