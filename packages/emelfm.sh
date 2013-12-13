PACKAGE_VERSION="0.9.2"
PACKAGE_SOURCES="http://emelfm.sourceforge.net/emelfm-$PACKAGE_VERSION.tar.gz"

emelfm_build() {
	[ -d emelfm-$PACKAGE_VERSION ] && rm -rf emelfm-$PACKAGE_VERSION
	tar -xzvf emelfm-$PACKAGE_VERSION.tar.gz
	cd emelfm-$PACKAGE_VERSION

	sed -e s~'CC = .*'~"CC = $CC"~ \
	    -e s~'PREFIX = .*'~'PREFIX = '~ \
	    -e s~'PLUGINS_DIR = .*'~'PLUGINS_DIR = $(PREFIX)/lib/emelfm/plugins'~ \
	    -e s~'DOC_DIR = .*'~'DOC_DIR = $(PREFIX)/usr/share/doc/emelfm'~ \
	    -e s~'NLS = -DENABLE_NLS'~'NLS ='~ \
	    -i Makefile.common

	sed -e s~'emelfm plugins nls'~'emelfm nls'~ \
	    -e s~'cd plugins; make install'~'# &'~ \
	    -i Makefile

	$MAKE
}

emelfm_package() {
	install -D -m 755 emelfm "$1/bin/emelfm"
	install -D -m 644 README "$1/usr/share/doc/emelfm/README"
	install -D -m 644 docs/help.txt \
	                  "$1/usr/share/doc/emelfm/docs/help.txt"
	install -m 644 COPYING "$1/usr/share/doc/emelfm/COPYING"
}
