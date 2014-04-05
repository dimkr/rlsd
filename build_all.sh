#!/bin/sh

. ./config

# available package groups
CORE="linux_headers
      musl
      lazy_utils
      loksh
      findutils
      xz_embedded
      lbzip2
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
      rfkill
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
              xev
              xmodmap
              terminus_font
              conky
              glib
              gtk
              lpackage
              aterm
              grun
              gtkfind
              gtkedit
              calcoo
              guitar
              libpng
              jwm
              libjpeg_turbo
              tiff
              gtksee
              gdk_pixbuf
              libxml2
              rox
              woof_ce_icons"
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
                alsa_lib
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
