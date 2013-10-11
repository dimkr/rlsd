PACKAGE_VERSION="2013.59"
PACKAGE_SOURCES="https://matt.ucc.asn.au/dropbear/releases/dropbear-$PACKAGE_VERSION.tar.bz2"

PROGRAMS="dropbear dbclient dropbearkey scp"

dropbear_build() {
	[ -d dropbear-$PACKAGE_VERSION ] && rm -rf dropbear-$PACKAGE_VERSION
	tar -xjvf dropbear-$PACKAGE_VERSION.tar.bz2
	cd dropbear-$PACKAGE_VERSION

	sed s~'^#define LOCAL_IDENT .*'~'#define LOCAL_IDENT "SSH-2.0-None"'~ \
	    -i sysoptions.h

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --enable-zlib \
	            --disable-pam
	make PROGRAMS="$PROGRAMS" MULTI=1
}

dropbear_package() {
	install -D -m 755 dropbearmulti "$1/bin/dropbear"
	for i in $PROGRAMS ssh
	do
		[ "dropbear" = "$i" ] && continue
		ln -s dropbear "$1/bin/$i"
	done
	for i in *.8
	do
		install -D -m 644 $i "$1/usr/share/man/man8/$i"
	done
	for i in *.1
	do
		install -D -m 644 $i "$1/usr/share/man/man1/$i"
	done
	install -D -m 644 README "$1/usr/share/doc/dropbear/README"
	install -D -m 644 LICENSE "$1/usr/share/doc/dropbear/LICENSE"
}
