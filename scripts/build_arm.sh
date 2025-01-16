#!/bin/bash
set -e

# brdata:src,-cache
tar -zxf /output_brdata.tar.gz -C /tmp
# notes: clear old cache ##700M> 370M;
\cp -a /tmp/brdata/build_buildroot_dl/* /build/buildroot/dl/
ls -lh /build/buildroot/dl/; du -sh /build/buildroot/dl

# 
mkdir -p /build/patches/linux
# mkdir -p /build/buildroot/dl/util-linux
# ##4.9M ref _ref\config\BR_2002_K540.md
# curl -k -fSL -o /build/buildroot/dl/util-linux/util-linux-2.35.1.tar.xz \
#   https://gitee.com/g-system/fk-barge-os/releases/download/v2305-ke-start/util-linux-2.35.1.tar.xz

# Add the basics startup scripts
cp -f ${OVERLAY}/etc/init.d/* package/initscripts/init.d/
install -C -m 0755 package/initscripts/init.d/* ${OVERLAY}/etc/init.d/

#############
\cp -a ${SRC_DIR}/configs/arm64/* ${SRC_DIR}/configs/
cat ${SRC_DIR}/configs/buildroot.config |grep nocona ||echo "nocona, not exist"

\cp -a ${SRC_DIR}/configs/buildroot.config ${BR_ROOT}/.config && \
    \cp -a ${SRC_DIR}/configs/busybox.config ${BR_ROOT}/package/busybox/busybox.config

make oldconfig
# make --quiet

###########
echo "make --quiet  ARCH=aarch64"; sleep 5
make --quiet  ARCH=aarch64 -j $(nproc)
# make $MAKE_QUIET ARCH=$arch "OUT_D=$OUT/build/$arch" ${CCACHE_D:+"BR2_CCACHE_DIR=${CCACHE_D}/$arch"} #cirros
# make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- #fos
