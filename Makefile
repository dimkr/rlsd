########################
# internal definitions #
########################

SYSROOT ?= $(shell pwd)/sysroot
PACKAGES = $(shell ls packages/ | cut -f 1 -d .)

all: iso

$(PACKAGES):
	SYSROOT="$(SYSROOT)" ./scripts/build_package $@

packages: $(PACKAGES)
	cd repo; repodude repo.csv repo.sqlite3

images:
	./scripts/create_tar rootfs
	./scripts/create_iso console
	./scripts/create_iso graphical
	./scripts/create_iso uefi

include ./Makefile.deps
