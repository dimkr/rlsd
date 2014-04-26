##################
# built packages #
##################

CORE = musl lazy_utils linux
CONSOLE_TOOLS = mandoc wget findutils bc diffutils patch
BOOT_LOADERS = isolinux elilo
NETWORK_TOOLS = dhcpcd rfkill iw wpa_supplicant
COMPRESSION = gzip lbzip2 xz libarchive squashfs_tools
SERVERS = dropbear bftpd
AUDIO = mpg123 tinyunmute
NCURSES_APPS = dialog less bwm_ng htop vile screen ytree lynx ircii calcurse \
               ncdu nano shed
X = tinyxlib tinyxserver
X_TOOLS = xev xmodmap
X_APPS = jwm aterm conky x11vnc
GTK_APPS = guitar gtksee rox gtkdialog1 beaver gdmap xchat xhippo guiftp \
           gtklepin gtkfontsel gcolor gtkcat gtkdiskfree dillo sylpheed \
           mhwaveedit mtpaint grun lpackage gtkfind gtkedit calcoo gcalendar

########################
# internal definitions #
########################

SYSROOT ?= $(shell pwd)/sysroot
PACKAGES = $(CORE) $(CONSOLE_TOOLS) $(BOOT_LOADERS) $(NETWORK_TOOLS) \
           $(COMPRESSION) $(SERVERS) $(AUDIO) $(NCURSES_APPS) $(X) $(X_TOOLS) \
           $(X_APPS) $(GTK_APPS)

all: iso

iso: $(PACKAGES)
	SYSROOT="$(SYSROOT)" ./scripts/create_iso

%:
	SYSROOT="$(SYSROOT)" ./scripts/build_package $@

########################
# package dependnecies #
########################

# core
musl: linux_headers
fuse: musl
lazy_utils: musl fuse

# console tools
$(CONSOLE_TOOLS): musl

# compression
$(COMPRESSION): musl
zlib: musl
libarchive: zlib lbzip2 xz

# boot loaders
gnu_efi: musl
elilo: gnu_efi

# network tools
$(NETWORK_TOOLS): musl
libnl_tiny: musl
iw wpa_supplicant: libnl_tiny

# servers
$(SERVERS): musl
dropbear bftpd: zlib

# audio
tinyalsa: musl
$(AUDIO): tinyalsa musl

# ncurses applications
ncurses: musl
$(NCURSES_APPS): musl ncurses

# X
$(X): musl
tinyxserver: zlib

# X tools
$(X_TOOLS): tinyxlib

# X applications
$(X_APPS): tinyxlib
libpng: zlib
jwm: libpng flattr_icons
terminus_font:
conky: terminus_font
libjpeg_turbo: musl
x11vnc: libjpeg_turbo

# GTK+ applications
glib: musl
gtk: glib tinyxlib terminus_font

$(GTK_APPS): gtk

giflib: musl

gifsicle: giflib

mtpaint: libjpeg_turbo libpng tiff gifsicle

alsa_lib: musl

mhwaveedit: alsa_lib

tiff: musl zlib libjpeg_turbo

gdk_pixbuf: libjpeg_turbo libpng tiff

gtksee gtkdialog1: gdk_pixbuf

libxml2: musl

rox: libxml2 gdk_pixbuf

guitar: libarchive
