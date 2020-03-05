# Define versions
VERSION_MAJOR?=0
VERSION_MINOR?=0
VERSION_MAINT?=0


LD_FLAGS=-lm

# Jenkins run-time build id
BUILD_NUMBER?=0

PKG_VERSION=$(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_MAINT)-$(BUILD_NUMBER)

PKG_NAME=r1exportfs
PKG_NAME_FULL=$(PKG_NAME)_$(PKG_VERSION)

all: build

build:
	gcc -Wall -o r1exportfs r1exportfs.c `pkg-config fuse --cflags --libs` $(LD_FLAGS)

release: build
	mkdir -p tmp/$(PKG_NAME_FULL)
	mkdir -p tmp/$(PKG_NAME_FULL)/opt/r1soft/$(PKG_NAME)/bin/
	cp $(PKG_NAME) tmp/$(PKG_NAME_FULL)/opt/r1soft/$(PKG_NAME)/bin/
	mkdir -p tmp/$(PKG_NAME_FULL)/DEBIAN 
	echo "Package: $(PKG_NAME)" > tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Version: $(PKG_VERSION)" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Section: base" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Priority: required" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Architecture: amd64" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Depends: sqlite3" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Maintainer: R1Soft Development  <Development@r1soft.com>" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	echo "Description: R1Soft's $(PKG_NAME) service" >> tmp/$(PKG_NAME_FULL)/DEBIAN/control
	cd tmp && fakeroot dpkg-deb --build $(PKG_NAME_FULL)
	mkdir -p targets
	mv tmp/$(PKG_NAME_FULL).deb targets/

clean:
	rm -f *.xml
	rm -f r1exportfs
	rm -rf targets/
	rm -rf tmp/
