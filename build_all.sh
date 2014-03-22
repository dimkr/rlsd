#!/bin/sh

. ./config

# available package groups
CORE="linux_headers
      musl
      lazy_utils
      loksh
      findutils
      xz_embedded
      zlib
      libarchive
      isolinux
      gnu_efi
      elilo
      mandoc
      wget
      dropbear
      bftpd
      dhcpcd
      libnl_tiny
      iw
      wpa_supplicant
      tinyalsa
      tinyunmute
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
              conky
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
              vile
              screen
              ytree
              htop
              lynx
              ircii
              calcurse
              ncdu
              nano
              bwm_ng"
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
                dillo
                sylpheed
                x11vnc"

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

# generate font cache files
cd "$SYSROOT/usr/share/fonts/misc"
mkfontscale
mkfontdir
