PACKAGE_VERSION="1.97"
PACKAGE_SOURCES="http://www.han.de/~werner/ytree-$PACKAGE_VERSION.tar.gz"

ytree_build() {
	[ -d ytree-$PACKAGE_VERSION ] && rm -rf ytree-$PACKAGE_VERSION
	tar -xzvf ytree-$PACKAGE_VERSION.tar.gz
	cd ytree-$PACKAGE_VERSION

	sed s~'#ifdef HAS_REGEX'~'#define HAS_REGCOMP\n#undef HAS_REGEX\n&'~ -i match.c
	sed -e s~'LDFLAGS     += -lncurses -lreadline'~'LDFLAGS     += -lncurses'~ \
	    -e s~'-DREADLINE_SUPPORT'~''~ \
	    -e s~'ADD_CFLAGS  = -O'~'ADD_CFLAGS  ='~ \
	    -e s~'DESTDIR     = /usr'~'DESTDIR     = /'~ \
	    -e s~'\$(DESTDIR)/share/man'~'$(DESTDIR)/usr/share/man'~g \
	    -e s~'install \$(MAIN) \$(BINDIR)'~'install -D $(MAIN) $(BINDIR)/$(MAIN)'~ \
	    -e s~'install -m 0644 ytree.1.gz  \$(MANDIR)/'~'install -D -m 0644 ytree.1.gz  $(MANDIR)/ytree.1.gz'~ \
	    -e s~'install -m 0644 ytree.1.es.gz \$(MANESDIR)/'~'install -D -m 0644 ytree.1.es.gz $(MANESDIR)/ytree.1.es.gz'~ \
	    -i Makefile

	make CC="$CC"
}

ytree_package() {
	mkdir -p "$1/usr/share/man/man1" "$1/usr/share/man/es/man1"
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/ytree/README"
	install -m 644 CHANGES "$1/usr/share/doc/ytree/CHANGES"
	install -m 644 THANKS "$1/usr/share/doc/ytree/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/ytree/COPYING"
}
