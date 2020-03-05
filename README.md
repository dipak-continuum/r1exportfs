# r1exportfs

**r1exportfs** is a [FUSE](http://www.linux.org/threads/fuse.6211/) file system driver that exposes a virtual file system to export mounted block devices as regular files.

## Build Dependencies
The following packages are required in order to build r1exportfs:

1. make
2. gcc
3. pkg-config
3. libfuse-dev

## Bulding And Debugging

### Building
Type make to build the r1exportfs binary or "make all" to build the r1exportfs Debian package. The Debian package will be created under the "targets" directory. You can also type "make clean" to clean the binaries and Debian package.

### Debugging
Activities for **r1exportfs** are logged to syslog. By default, only errors and warnings are written to syslog. To turn on debugging, simply change the statement LOG\_UPTO(LOG\_WARN)) to LOG\_UPTO(LOG\_INFO)) and extra information will written to syslog to help you debug.

## Configuring and Running r1exportfs
### Configuration File Syntax
**r1exportfs** uses a simple configuration file in order to export mounted block devices as regular files. The syntax is comprised of key value pair lines. Each key value pair is separated by an equal sign. The left side of the equal sign contains the full path to the block device while the right side of the equal sign contains the path to the file that is mapped to the block device. It is important to mention that the path the right side of the equal sign must start with / since the file path represents the path relative to the root mount point. Here is an example of a configuration file.

        /dev/sdc=/disk1.vmdk
        /dev/sdd=/subdirectory/disk2.vmdk

### Running r1exportfs
To run **r1exportfs**, simply type: **r1exportfs rootDir mountDir config** where:

1. **rootDir**: the directory that will be mounted under mountDir. This directory is the real directory that provides the back-end for the virtual directory mountDir.
2. **mountDir**: the virtual directory that uses rootDir as its back-end. Files under this directory that are mapped under the configuration file are really block devices that are presented as regular files.
3. **config**: the r1exportfs configuration file.

