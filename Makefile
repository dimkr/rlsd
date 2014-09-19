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

iso:
	./scripts/create_iso uefi
	./scripts/create_iso bios
	./scripts/create_iso minimal

include ./Makefile.deps
