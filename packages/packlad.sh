PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/packlad/archive/master.zip,packlad-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A package manager"

packlad_build() {
	[ -d packlad-master ] && rm -rf packlad-master
	unzip packlad-$PACKAGE_VERSION.zip
	cd packlad-master

	for i in "$BASE_DIR"/*_key "$BASE_DIR"/*_key.h
	do
		cp "$i" core/
	done

	$MAKE
}

packlad_package() {
	for i in core/*_key core/*_key.h
	do
		cp $i "$BASE_DIR/"
	done
	
	$MAKE DESTDIR="$1" install
}
