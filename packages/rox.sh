PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/rox/archive/master.zip,rox-$PACKAGE_VERSION.zip"
PLATFORM="$(uname -s)-$(uname -m)"

rox_build() {
	[ -d rox-master ] && rm -rf rox-master
	unzip rox-$PACKAGE_VERSION.zip
	cd rox-master

	patch -p 1 < "$BASE_DIR/patches/rox-aterm.patch"

	cd ROX-Filer/src
	XML_CONFIG="xml2-config" ./configure --host=$HOST --with-platform=$PLATFORM
	$MAKE
}

rox_package() {
	cd ..

	mkdir -p "$1/usr/share/rox"
	for i in AppInfo.xml \
	         AppRun \
	         Help \
	         Messages \
	         Options.xml \
	         pixmaps \
	         style.css \
	         Styles
	do
		cp -r $i "$1/usr/share/rox"
	done

	install -D -m 755 $PLATFORM/ROX-Filer "$1/lib/rox/ROX-Filer"
	ln -s ../../../lib/rox "$1/usr/share/rox/$PLATFORM"

	mkdir "$1/bin"
	echo "#!/bin/sh
exec /usr/share/rox/AppRun \"\$@\"" > "$1/bin/rox"
	chmod 755 "$1/bin/rox"
}
