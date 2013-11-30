#!/bin/sh

. ./config

# available package groups
CORE="linux_headers
      musl
      lazy_utils
      loksh
      gnu_efi
      elilo
      mandoc
      ncurses
      zlib
      dhcp
      linux"
MULTIMEDIA="alsa_lib mpg123 alsa_utils libogg libvorbis vorbis_tools"
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
CORE_APPS="less vile screen dropbear aterm emelfm beaver"
EXTRA_APPS="htop
            lynx
            ircii
            calcurse
            ncdu
            bwm_ng
            unnethack
            gdmap
            xchat
            libpng
            libjpeg_turbo
            mtpaint"

# built packages
ALL="$CORE $X_SERVER $LIBXFT $WINDOW_MANAGER $GTK $CORE_APPS $EXTRA_APPS"

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