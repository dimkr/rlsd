PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/useatbelt/archive/master.zip,useatbelt-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A driver loader"

useatbelt_build() {
	[ -d useatbelt-master ] && rm -rf useatbelt-master
	unzip useatbelt-$PACKAGE_VERSION.zip
	cd useatbelt-master

	$MAKE
}

useatbelt_package() {
	$MAKE DESTDIR="$1" SBIN_DIR="/bin" install
}
