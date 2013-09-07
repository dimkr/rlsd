ORIGINAL_WORKING_DIRECTORY="$(pwd)"
BINARY_TARBALL_DIR="$ORIGINAL_WORKING_DIRECTORY"

. ./config

export AR
export CFLAGS="$CFLAGS -I$SYSROOT/usr/include"
export LDFLAGS="$LDFLAGS -L$SYSROOT/lib"
export PKG_CONFIG_PATH="$SYSROOT/lib/pkgconfig"

if [ -e $SYSROOT/bin/musl-gcc ]
then
	export CC="$SYSROOT/bin/musl-gcc"
else
	export CC
fi

if [ ! -e ./packages/$1.sh ]
then
    echo "Invalid package name"
    exit 1
fi

. ./packages/$1.sh

[ -e /tmp/$1 ] && rm -rf /tmp/$1

cd x

for i in $PACKAGE_SOURCES
do
    echo $i
    case "$i" in
        ftp://*|http://*|https://*)
			case "$i" in
				*,*)
					output_file="${i##*,}"
					url="${i%%,*}"
					;;

				*)
					output_file="${i##*/}"
					url="$i"
					;;
			esac

			[ -f "$output_file" ] && continue
			wget "$url" -O "$output_file"
			;;
    esac
done

${1}_build
${1}_package /tmp/$1
[ -d /tmp/$1/lib ] && rm -vf /tmp/$1/lib/*.la
[ -d /tmp/$1/bin ] && $STRIP --strip-all /tmp/$1/bin/*
tar -C /tmp/$1 -c . | xz -9 -e > "$BINARY_TARBALL_DIR/$1-$PACKAGE_VERSION.txz"
mkdir -p $SYSROOT
cd $SYSROOT
tar -xJvf "$BINARY_TARBALL_DIR/$1-$PACKAGE_VERSION.txz"
rm -rf /tmp/$1
