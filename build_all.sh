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
      axel
      dropbear
      dhcpcd
      libnl
      wireless_tools
      wpa_supplicant
      tinyalsa
      mpg123
      fuse
      luufs
      linux"
DESKTOP_CORE="tinyxlib
              tinyxserver
              terminus_font
              freetype
              libxml2
              fontconfig
              libxft
              dejavu_fonts
              ratpoison
              glib
              gtk
              lpackage
              aterm
              gtkfind
              gtkedit
              calcoo
              guitar
              libpng
              libjpeg_turbo
              tiff
              gtksee
              gdk_pixbuf
              rox"
CONSOLE_APPS="ncurses
              less
              joe
              screen
              ytree
              htop
              lynx
              ircii
              calcurse
              ncdu
              bwm_ng
              unnethack"
GRAPHICAL_APPS="beaver
                gdmap
                xchat
                xhippo
                guiftp
                gtklepin
                gtkfontsel
                gcolor
                gtkcat
                gtkdiskfree
                mhwaveedit
                giflib
                mtpaint
                dillo"

# built packages
ALL="$CORE
     $DESKTOP_CORE
     $CONSOLE_APPS
     $GRAPHICAL_APPS"

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