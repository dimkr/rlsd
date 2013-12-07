#!/bin/sh

. ./config

# available package groups
CORE="linux_headers
      musl
      lazy_utils
      loksh
      tar
      gzip
      gnu_efi
      elilo
      mandoc
      ncurses
      zlib
      axel
      dhcp
      linux"
CORE_MULTIMEDIA="alsa_lib alsa_utils mpg123"
EXTRA_MULTIMEDIA="libogg libvorbis vorbis_tools"
X_SERVER="tinyxlib
          xinit
          tinyxserver
          font_cursor_misc
          font_misc_misc
          font_alias
          terminus_font"
LIBXFT="freetype libxml2 fontconfig libxft ttf_bitstream_vera"
WINDOW_MANAGER="ratpoison"
GTK="glib gtk"
CORE_APPS="less vile screen ytree dropbear aterm emelfm gtkedit"
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
            gtkfontsel
            gtkdiskfree
            mhwaveedit
            libpng
            libjpeg_turbo
            giflib
            meh
            mtpaint"

# built packages
ALL="$CORE $X_SERVER $LIBXFT $WINDOW_MANAGER $GTK $CORE_APPS $CORE_MULTIMEDIA $EXTRA_APPS"

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