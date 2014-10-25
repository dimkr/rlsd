PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://raw.githubusercontent.com/bagder/curl/master/lib/mk-ca-bundle.pl,mk-ca-bundle-$PACKAGE_VERSION.pl http://mxr.mozilla.org/mozilla/source/security/nss/COPYING?raw=1,COPYING"
PACKAGE_DESC="CA certificates"
PACKAGE_ARCH="all"

build() {
	perl mk-ca-bundle-$PACKAGE_VERSION.pl cert.pem
}

package() {
	install -D -m 644 cert.pem "$1/etc/ssl/cert.pem"
	install -D -m 644 COPYING "$1/usr/share/doc/ca-certificates/COPYING"
}

