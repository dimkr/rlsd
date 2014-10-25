PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/rox/archive/master.zip,rox-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A file manager"

PLATFORM="$(uname -s)-$(uname -m)"

build() {
	[ -d rox-master ] && rm -rf rox-master
	unzip rox-$PACKAGE_VERSION.zip
	cd rox-master

	patch -p 1 < "$BASE_DIR/patches/rox-platform.patch"
	patch -p 1 < "$BASE_DIR/patches/rox-locale.patch"
	patch -p 1 < "$BASE_DIR/patches/rox-choices.patch"

	cd ROX-Filer/src
	./configure --host=$HOST --with-platform=$PLATFORM --with-xterm=aterm
	$MAKE
}

package() {
	cd ..

	mkdir -p "$1/usr/share/rox"
	for i in AppInfo.xml \
	         AppRun \
	         Options.xml \
	         pixmaps \
	         style.css \
	         Styles
	do
		cp -r $i "$1/usr/share/rox"
	done

	install -d -m 755 "$1/usr/share/rox/Help"
	cd Help
	for i in *
	do

		case "$i" in
			*-*)
				;;
			*)
				install -m 755 "$i" "$1/usr/share/rox/Help/$i"
				;;
		esac
	done

	install -D -m 755 ../$PLATFORM/ROX-Filer "$1/lib/rox/ROX-Filer"

	mkdir "$1/bin"
	echo "#!/bin/sh
exec /usr/share/rox/AppRun \"\$@\"" > "$1/bin/rox"
	chmod 755 "$1/bin/rox"

	install -D -d -m 755 "$1/usr/share/doc"
	ln -s ../rox/Help "$1/usr/share/doc/rox"
}
