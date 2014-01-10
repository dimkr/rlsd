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
      tinyalsa
      mpg123
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
              uxplor
              gtkfind
              gtkedit
              calcoo
              guitar"
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
                emelfm
                gtkdiskfree
                mhwaveedit
                libpng
                libjpeg_turbo
                giflib
                meh
                mtpaint
                tiff
                gdk_pixbuf
                rox"

# built packages
ALL="$CORE
     $DESKTOP_CORE
     $CORE_APPS
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