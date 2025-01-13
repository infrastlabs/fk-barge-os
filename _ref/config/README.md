
- buildroot
  - https://gitee.com/g-system/fk-buildroot #`25.1: 7.5w`
    - `br.x40:2017~2024.{02/05/08/11}.x`
    - `tag: 2024.02.{1..10}/23.02.11/22.02.12/21.02.12/20.02.12/19.02.11`
  - https://buildroot.org/download.html #`LTS:2024.02.10`
  - https://buildroot.org/docs.html #`html,pdf, Training`
  - https://buildroot.org/downloads/manual/manual.html #`menu`
  - https://bootlin.com/doc/training/buildroot/buildroot-slides.pdf
  - https://bootlin.com/doc/training/buildroot/buildroot-labs.pdf

```bash
headless @ barge in .../working/_ee |17:26:34  
$ git clone --branch=2024.02.10 --depth=1  https://gitee.com/g-system/fk-buildroot 
$ git clone https://gitee.com/g-system/fk-barge-os
# headless @ barge in .../_ee/fk-buildroot |18:03:08  |tag:2024.02.10 ?:4 _| 
$ cd fk-buildroot/
$ cp ../fk-barge-os/configs/buildroot.config .config
# headless @ barge in .../_ee/fk-buildroot |18:02:45  |tag:2024.02.10 ?:4 _| 
$ sudo apt install  libncurses-dev
$ make menuconfig #手动save 

headless @ barge in .../_ee/fk-buildroot |18:02:38  |tag:2024.02.10 ?:4 _| 
$ ls -lha
total 1.9M
-rw-r--r--    1 headless headless 101K Jan 13 17:29 .config
-rw-r--r--    1 headless headless 133K Jan 13 17:38 .config-2s
-rw-r--r--    1 headless headless 129K Jan 13 18:02 .config-2s2
-rw-r--r--    1 headless headless 129K Jan 13 18:02 .config-2s2.old

# gitac-build
  >>> linux 5.10.162-cip24 Installing to target
  >>> linux 5.10.162-cip24 Installing to images directory
  >>>   Finalizing host directory
  >>>   Finalizing target directory
  >>>   Sanitizing RPATH in target tree
  >>>   Copying overlay /overlay
  >>>   Executing post-build script /build/scripts/post_build.sh
  /build/buildroot/output/target/../host/x86_64-buildroot-linux-gnu/sysroot/usr/bin/localedef: /lib/x86_64-linux-gnu/libc.so.6: version 'GLIBC_ABI_DT_RELR' not found (required by /build/buildroot/output/target/../host/x86_64-buildroot-linux-gnu/sysroot/usr/bin/localedef)
  /build/buildroot/output/target/../host/x86_64-buildroot-linux-gnu/sysroot/usr/bin/localedef: /lib/x86_64-linux-gnu/libc.so.6: version 'GLIBC_2.38' not found (required by /build/buildroot/output/target/../host/x86_64-buildroot-linux-gnu/sysroot/usr/bin/localedef)
  make: *** [Makefile:752: target-finalize] Error 1
  make: *** [Makefile:27: build] Error 2

# conf02
  # Copy config files
  COPY configs ${SRC_DIR}/configs
  RUN cp ${SRC_DIR}/configs/buildroot.config ${BR_ROOT}/.config && \
  cp ${SRC_DIR}/configs/busybox.config ${BR_ROOT}/package/busybox/busybox.config
  ##@buildroot.config: BR2_PACKAGE_BUSYBOX_CONFIG="package/busybox/busybox.config"
  ##@buildroot.config: BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="/build/configs/kernel.config"

# output
  root @ deb1013 in ~ |09:16:22  
  $ docker pull registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:v2501
  v2501: Pulling from infrastlabs/barge-build-output
  72cfd02ff4d0: Already exists 
  ab4cae77f3d3: Downloading [======================================>            ]  828.8MB/1.066GB
  root @ deb1013 in ~ |09:17:36  
  $ docker run -it --rm registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:v2501 sh
  / # find output/
  output/
  output/bzImage
  output/rootfs.tar.xz
  output/brdata.tar.gz
  output/barge.iso
  / # ls -lh output/
  total 1017M  
  -rw-r--r--    1 root     root       48.0M Jan 13 23:49 barge.iso
  -rw-r--r--    1 root     root      920.0M Jan 13 23:49 brdata.tar.gz
  -rw-r--r--    1 root     root        3.1M Jan 13 23:45 bzImage
  -rw-r--r--    1 root     root       45.5M Jan 13 23:47 rootfs.tar.xz  

# GLIBC_2.38| usr/bin/localedef --force --quiet --no-archive --little-endian --prefix=${ROOTFS} -i POSIX -f UTF-8 C.UTF-8
# /build/buildroot/output/target/../host/x86_64-buildroot-linux-gnu/sysroot/usr/bin/localedef: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.38' not found
  root @ deb1013 in ~ |09:35:00  
  $ docker run -it --rm registry.cn-shenzhen.aliyuncs.com/infrastlabs/x11-base:core-ubuntu-24.04 bash
  root@7c18ee39dbea:/# pkgsize |grep libc
  2.13 Mbs	libc-bin|2.39-0ubuntu8.3

  root @ deb1013 in ~ |09:36:52  
  $ docker run -it --rm registry.cn-shenzhen.aliyuncs.com/infrastlabs/x11-base:core-ubuntu-22.04 bash
  root@7c99bbc7fb18:/# pkgsize |grep libc
  2.48 Mbs	libc-bin ##22.04:无version!!
  root@7c99bbc7fb18:/# dpkg -l |grep libc-bin
  ii  libc-bin                      2.35-0ubuntu3.8                         amd64        GNU C Library: Binaries
```

**configs**

ref draft//2025\03-bargeos-initrd-kernel.md

- [barge](https://gitee.com/g-system/fk-barge-os/tree/sam-custom/configs) `[Buildroot 2019.08; BR2_LINUX_KERNEL_VERSION="4.14.125"]` buildroot/busybox/kernel; +device_table/user
  - https://gitee.com/g-system/fk-barge-os/raw/sam-custom/configs/buildroot.config
  - https://gitee.com/g-system/fk-barge-os/raw/sam-custom/configs/busybox.config
  - https://gitee.com/g-system/fk-barge-os/raw/sam-custom/configs/kernel.config
- [burmilla-os](https://gitee.com/g-system/fk-burmilla-os-initrd-base/tree/master/config) `[Buildroot 2022.02.3; BR2_DEFAULT_KERNEL_HEADERS="5.10.120"]`
  - https://gitee.com/g-system/fk-burmilla-os-initrd-base/raw/master/config/arm64/buildroot-config-static
  - https://gitee.com/g-system/fk-burmilla-os-initrd-base/raw/master/config/amd64/buildroot-config-static
  - https://gitee.com/g-system/fk-burmilla-os-initrd-base/raw/master/config/busybox-dynamic.config
- [k3s-root](https://gitee.com/g-system/fk-k3s-root/tree/master/buildroot) `[Buildroot 2024.02.3; BR2_DEFAULT_KERNEL_HEADERS="5.15.160"]` config+4{arm,arm64,x64,risc64}
  - https://gitee.com/g-system/fk-k3s-root/raw/master/buildroot/config
  - https://gitee.com/g-system/fk-k3s-root/raw/master/buildroot/amd64config part
  - https://gitee.com/g-system/fk-k3s-root/raw/master/buildroot/arm64config part
- [cirros](https://gitee.com/g-system/fk-cirros/tree/main/conf) `[Buildroot 2022.02.4; BR2_DEFAULT_KERNEL_HEADERS="5.10.120"]` busybox+4{arm,arm64,x64,ppc64}
  - https://gitee.com/g-system/fk-cirros/raw/main/conf/buildroot-aarch64.config
  - https://gitee.com/g-system/fk-cirros/raw/main/conf/buildroot-x86_64.config
  - https://gitee.com/g-system/fk-cirros/raw/main/conf/busybox.config
- [fogproject-fos](https://gitee.com/g-system/fk-fos/tree/master/configs) `[Buildroot 2024.02.9; BR2_DEFAULT_KERNEL_HEADERS="6.6.69"]` 6{arm64,x64,x86:fs/kernel}
  - https://gitee.com/g-system/fk-fos/raw/master/configs/fsarm64.config
  - https://gitee.com/g-system/fk-fos/raw/master/configs/fsx64.config
  - https://gitee.com/g-system/fk-fos/raw/master/configs/kernelarm64.config `112K`
  - https://gitee.com/g-system/fk-fos/raw/master/configs/kernelx64.config

```bash
barge{4.14.125/busybox,kernel}> burmilla-os{5.10.120/busybox}> k3s-root{5.15.160}
                      cirros{5.10.120/busybox}> fos{6.6.69/kernel}


# DIR结构
barge: configs, overlay, scripts; docs,patches,contrib
burmilla-os: config, scripts
k3s-root: buildroot, package, patches, scripts
cirros: conf, lxd-meta, patches-buildroot, src[rootfs]
fos: configs, patch, Buildroot/{board,package}


####################################
# Barge.FORKS
# https://github.com/ahmedbodi/barge-os/commit/d40763f7389468fb6ae3acf6ba7b9f01c904f382#diff-43453f510556d352276e897e137cb103b3bbca24acb6cba33208d4887b2e3c77R73
# up docs/build.md
# Rebuilding BuildRoot Configs
  git clone https://github.com/buildroot/buildroot buildroot
  cp ./barge-os/configs/buildroot.config buildroot/.config
  cd buildroot
  make menuconfig <- make any changes, remove old config settings then copy it back to barge-os
  cd ../barge-os
  make

  # ref Dockerfile
    # Setup environment
    ENV BR_VERSION 2019.08
    ENV SRC_DIR=/build \
        OVERLAY=/overlay \
        BR_ROOT=/build/buildroot
    RUN mkdir -p ${SRC_DIR} ${OVERLAY}

    # Copy config files
    COPY configs ${SRC_DIR}/configs
    RUN cp ${SRC_DIR}/configs/buildroot.config ${BR_ROOT}/.config && \
    cp ${SRC_DIR}/configs/busybox.config ${BR_ROOT}/package/busybox/busybox.config
    ##@buildroot.config: BR2_PACKAGE_BUSYBOX_CONFIG="package/busybox/busybox.config"
    ##@buildroot.config: BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="/build/configs/kernel.config"

# https://github.com/diyism/barge-os/commit/d7621868938840f234e87a6941f7fecaf0c98f9f
# docs/bargeos_on_digitalocean.md
  0. Download latest release barge.img file (13MB) from: https://github.com/bargees/barge-os/releases
  0. Login and goto https://cloud.digitalocean.com/images/custom_images
  0. Click "Upload Image" and select barge.img to upload
  0. Create Droplets/Custom images/barge.img
  0. ssh bargee@<vps ip> (password is also bargee)
  0. sudo fdisk -l, found the "EndLBA" is <26635>
  0. sudo fdisk /dev/vda, Command (m for help): n, Partition type: p, Partition number (1-4): 2, First sector: 26636 ... created new partition
  0. sudo mkfs.ext4 -b 4096 -i 4096 -L BARGE-DATA /dev/vda2
  0. sudo reboot
  0. ssh bargee@<vps ip> (password is still bargee)
  0. passwd (password only can be saved after we made BARGE-DATA partition)
  0. sudo reboot
  0. ssh bargee@<vps ip> (new password)
  0. sudo pkg install nano

####################################
# fk-burmilla-os-initrd-base
# _nux\_broot\fk-burmilla-os-initrd-base\scripts\config
  for arch in $ARCH; do
    ./scripts/build-busybox "config" ${CONFIG}/${arch}/buildroot-config-static ${CONFIG}/busybox-dynamic.config
# _nux\_broot\fk-burmilla-os-initrd-base\scripts\build-busybox
  busybox_install(){
    local build=$1
    local conf=$2
    local bbconf=$3
    tar xf ${ARTIFACTS}/${buildroot} -C ${DIR} --strip-components=1
    cd ${DIR}

    cp $conf .config
    cp $bbconf package/busybox/
    make menuconfig #if "$build" == "config"
    make oldconfig

####################################
# k3s-root
# _nux\_broot\fk-k3s-root\scripts\patch
  cat /source/buildroot/{"${BUILDARCH}config",config} > /usr/src/buildroot/.config #config+4{arm,arm64,x64,risc64}



####################################
# cirros
# _nux\_broot\fk-cirros\bin\build-arch
  cp "$confd/buildroot-$arch.config" "$confd/.config" #busybox+4{arm,arm64,x64,ppc64}
  cp "$confd/busybox.config" "$out/busybox.config"
  make "O=$BR_OUT" "BUSYBOX_CONFIG_FILE=$out/busybox.config" "$@"

####################################
# fos
# _nux\_broot\fk-fos\build.sh
function buildFilesystem() {
  cd fssource$arch #6{arm64,x64,x86:fs/kernel}
  cp ../configs/fs$arch.config .config
  make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- oldconfig #arm64
  make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig

function buildKernel() {
  cd kernelsource$arch #6{arm64,x64,x86:fs/kernel}
  make mrproper
  cp ../configs/kernel$arch.config .config
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- oldconfig
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig

```

