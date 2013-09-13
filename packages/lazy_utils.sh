PACKAGE_VERSION="master"
PACKAGE_SOURCES="https://github.com/iguleder/lazy-utils/archive/master.zip,lazy-utils-master.zip"

lazy_utils_build() {
	[ -d lazy-utils-master ] && rm -rf lazy-utils-master
	unzip lazy-utils-master.zip
	cd lazy-utils-master

	sh ./build.sh
}

lazy_utils_package() {
	sh ./install.sh "$1"
}
