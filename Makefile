########################
# internal definitions #
########################

PACKAGES = $(shell ls packages/ | cut -f 1 -d .)

all: images

$(PACKAGES):
	./scripts/build_package $@

packages: $(PACKAGES)

images:
	./scripts/create_tar rootfs
	./scripts/create_iso console
	./scripts/create_iso graphical
	./scripts/create_iso uefi

include ./Makefile.deps
