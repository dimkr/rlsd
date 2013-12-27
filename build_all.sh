#!/bin/sh

. ./config

# available package groups
CORE="linux_headers
      musl
      lazy_utils
      loksh
      xz_embedded
      zlib
      libarchive
      isolinux
      gnu_efi
      elilo
      mandoc
      ncurses
      axel
      dhcpcd
      dhcp
      linux"
CORE_MULTIMEDIA="tinyalsa mpg123"
X_SERVER="tinyxlib tinyxserver terminus_font"
LIBXFT="freetype libxml2 fontconfig libxft dejavu_fonts"
WINDOW_MANAGER="ratpoison"
GTK="glib gtk"
CORE_APPS="less
           vile
           screen
           ytree
           dropbear
           lpackage
           aterm
           uxplor
           gtkfind
           gtkedit
           calcoo
           guitar"
EXTRA_APPS="htop
            lynx
            ircii
            calcurse
            ncdu
            nano
            bwm_ng
            unnethack
            beaver
            gdmap
            xchat
            xhippo
            guiftp
            gtklepin
            gtkfontsel
            gcolor
            gtkcat
            emelfm
            gtkdiskfree
            mhwaveedit
            libpng
            libjpeg_turbo
            giflib
            meh
            mtpaint"

# built packages
ALL="$CORE
     $X_SERVER
     $LIBXFT
     $WINDOW_MANAGER
     $GTK
     $CORE_APPS
     $CORE_MULTIMEDIA
     $EXTRA_APPS"

# clean up
[ -d "$SYSROOT" ] && rm -rf "$SYSROOT"

# build all packages
for package in $ALL
do
	sh build.sh $package
done

# add the skeleton
cp -a skeleton/* "$SYSROOT/"

# generate font cache files
cd "$SYSROOT/usr/share/fonts/misc"
mkfontscale
mkfontdir