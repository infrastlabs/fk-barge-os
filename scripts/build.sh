#!/bin/bash
set -e

# brdata:src,-cache
tar -zxf /output_brdata.tar.gz -C /tmp
\cp -a /tmp/brdata/build_buildroot_dl/* /build/buildroot/dl/
ls -lh /build/buildroot/dl/; du -sh /build/buildroot/dl

# 
mkdir -p /build/patches/linux

# Add the basics startup scripts
cp -f ${OVERLAY}/etc/init.d/* package/initscripts/init.d/
install -C -m 0755 package/initscripts/init.d/* ${OVERLAY}/etc/init.d/

make oldconfig
make --quiet
