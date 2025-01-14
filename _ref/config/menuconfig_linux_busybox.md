

- **conf kernel/busybox**
  - linux-menuconfig #https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-5.10.162-cip24.tar.gz
  - busybox-menuconfig #https://www.busybox.net/downloads/busybox-1.36.1.tar.bz2


```bash
# build-img内查看，依旧为原来old配置;
root @ deb1013 in .../_ee/fk-barge-os |11:55:47  |sam-custom _| 
$ docker run -it --rm barge-builder sh
root@7229e3f69998:/build/buildroot# ls
  CHANGES  COPYING  Config.in  Config.in.legacy  DEVELOPERS  Makefile  Makefile.legacy  README  arch  board  boot  ccache  configs  dl  docs  fs  linux  package  support  system  toolchain  utils                                                                 
root@7229e3f69998:/build/buildroot# head -15 /build/configs/kernel.config
  #
  # Automatically generated file; DO NOT EDIT.
  # Linux/x86_64 4.14.125 Kernel Configuration
  #
  CONFIG_64BIT=y
  CONFIG_X86_64=y
  CONFIG_X86=y
  CONFIG_INSTRUCTION_DECODER=y
  CONFIG_OUTPUT_FORMAT="elf64-x86-64"
  CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
root@7229e3f69998:/build/buildroot# cat package/busybox/busybox.config |wc
   1183    3337   32090
root@7229e3f69998:/build/buildroot# head -15 package/busybox/busybox.config
  #
  # Automatically generated make config: don't edit
  # Busybox version: 1.31.0
  # Fri Aug 16 00:25:41 2019
  #
  CONFIG_HAVE_DOT_CONFIG=y

  #
  # Settings
  #
  CONFIG_DESKTOP=y
  # CONFIG_EXTRA_COMPAT is not set
  # CONFIG_FEDORA_COMPAT is not set

########
# BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE BR2_PACKAGE_BUSYBOX_CONFIG
# https://www.cnblogs.com/justin-y-lin/p/9166853.html
# make linux-menuconfig; make busybox-menuconfig
```

## Detail

- 1）try 40.253-vmbarge, `fk-buildroot下会编译前置组件`，磁盘满换机40.252/barge-builder;

```bash
# fk-buildroot下执行 make linux-menuconfig，全编译一遍。。################################
headless @ barge in .../_ee/fk-buildroot |12:05:18  |tag:2024.02.10 ?:7 ✗| 
  $ make linux-menuconfig
  Makefile.legacy:9: *** "You have legacy configuration in your .config! Please check your configuration.".  Stop.

  $ make linux-menuconfig
  You must install 'cpio' on your build machine
  You must install 'bc' on your build machine
  make: *** [support/dependencies/dependencies.mk:27: dependencies] Error 1

# https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-5.10.162-cip24.tar.gz
# https://dl1.serctl.com/downloads8/2025-01-14-12-18-38-git-linux-cip-5.10.162-cip24.tar.gz ##177M
  headless @ barge in .../_ee/fk-buildroot |12:07:17  |tag:2024.02.10 ?:7 ✗| 
  $ make linux-menuconfig
  >>> linux 5.10.162-cip24 Downloadingwget --passive-ftp -nd -t 3 -O '/_ext/working/_ee/fk-buildroot/output/build/.linux-cip-5.10.162-cip24.tar.gz.jTP0cL/output' 'https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-5.10.162-cip24.tar.gz' --2025-01-14 12:07:25--  https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-5.10.162-cip24.tar.gz
  Resolving git.kernel.org (git.kernel.org)... 145.40.73.55, 2604:1380:40e1:4800::1
  Connecting to git.kernel.org (git.kernel.org)|145.40.73.55|:443... connected.
# headless @ barge in .../_ee/fk-buildroot |13:50:09  |tag:2024.02.10 ?:7 ✗| 
  $ sudo mkdir -p /build/patches /build/configs/
  $ sudo cp ../fk-barge-os/configs/kernel.config /build/configs/
  $ sudo chown headless:headless -R /build/configs/
  # https://cmake.org/files/v3.28/cmake-3.28.3.tar.gz
  $ make linux-menuconfig
    >>> host-skeleton  Extracting
    >>> host-skeleton  Patching
    >>> host-skeleton  Configuring
    >>> host-skeleton  Building
    >>> host-skeleton  Installing to host directory
    # check-package DoNotInstallToHostdirUsr
    >>> host-cmake 3.28.3 Downloading
    wget --passive-ftp -nd -t 3 -O '/_ext/working/_ee/fk-buildroot/output/build/.cmake-3.28.3.tar.gz.UiK4pM/output' 'https://cmake.org/files/v3.28/cmake-3.28.3.tar.gz' 
    --2025-01-14 13:52:39--  https://cmake.org/files/v3.28/cmake-3.28.3.tar.gz
    Resolving cmake.org (cmake.org)... 66.194.253.25
    Connecting to cmake.org (cmake.org)|66.194.253.25|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 11067653 (11M) [application/x-gzip]
    Saving to: '/_ext/working/_ee/fk-buildroot/output/build/.cmake-3.28.3.tar.gz.UiK4pM/output'
  # https://github.com/redis/hiredis/archive/v1.2.0/hiredis-1.2.0.tar.gz
  >>> host-hiredis 1.2.0 Downloading
  wget --passive-ftp -nd -t 3 -O '/_ext/working/_ee/fk-buildroot/output/build/.hiredis-1.2.0.tar.gz.a6osKG/output' 'https://github.com/redis/hiredis/archive/v1.2.0/hiredis-1.2.0.tar.gz' 
  --2025-01-14 13:59:34--  https://github.com/redis/hiredis/archive/v1.2.0/hiredis-1.2.0.tar.gz
  # https://github.com/facebook/zstd/releases/download/v1.5.5/zstd-1.5.5.tar.gz
  >>> host-zstd 1.5.5 Downloading
  wget --passive-ftp -nd -t 3 -O '/_ext/working/_ee/fk-buildroot/output/build/.zstd-1.5.5.tar.gz.YTFntS/output' 'https://github.com/facebook/zstd/releases/download/v1.5.5/zstd-1.5.5.tar.gz' 
  --2025-01-14 14:00:57--  https://github.com/facebook/zstd/releases/download/v1.5.5/zstd-1.5.5.tar.gz
  Resolving github.com (github.com)... 20.205.243.166
  Connecting to github.com (github.com)|20.205.243.166|:443... connected.
  # https://github.com/ccache/ccache/releases/download/v4.8.2/ccache-4.8.2.tar.xz
  >>> host-ccache 4.8.2 Downloading
  wget --passive-ftp -nd -t 3 -O '/_ext/working/_ee/fk-buildroot/output/build/.ccache-4.8.2.tar.xz.lBg21C/output' 'https://github.com/ccache/ccache/releases/download/v4.8.2/ccache-4.8.2.tar.xz' 
  --2025-01-14 14:01:21--  https://github.com/ccache/ccache/releases/download/v4.8.2/ccache-4.8.2.tar.xz
  Resolving github.com (github.com)... 20.205.243.166

  # libbison
  # host-binutils-2.40
  # mpfr
  # gcc-12.4 @cn.repo
  # glibc-2.38-81 ##disk full err.
    {standard input}: Assembler messages:
    {standard input}: Fatal error: can\'t write 7 bytes to section .text of /_ext/working/_ee/fk-buildroot/output/build/glibc-2.38-81-gc8cb4d2b86ece572793e31a3422ea29e88d77df5/build/string/strcasecmp_l-nonascii.os: 'No space left on device'
    ../sysdeps/x86_64/strcasecmp_l-nonascii.c:9: fatal error: closing dependency file /_ext/working/_ee/fk-buildroot/output/build/glibc-2.38-81-gc8cb4d2b86ece572793e31a3422ea29e88d77df5/build/string/strcasecmp_l-nonascii.os.dt: No space left on device
    {standard input}: Fatal error: /_ext/working/_ee/fk-buildroot/output/build/glibc-2.38-81-gc8cb4d2b86ece572793e31a3422ea29e88d77df5/build/string/strcasecmp_l-nonascii.os: No such file or directory

# viewSize ################################################################
headless @ barge in .../_ee/fk-buildroot |14:33:07  |tag:2024.02.10 ✓| 
  $ du -sh *
  552K    CHANGES
  20K     COPYING
  32K     Config.in
  168K    Config.in.legacy
  84K     DEVELOPERS
  48K     Makefile
  4.0K    Makefile.legacy
  4.0K    README
  140K    arch
  5.6M    board
  776K    boot
  98M     ccache
  1.2M    configs
  2.5M    docs
  260K    fs
  92K     linux
  343M    dl ##########
  5.0G    output ##########
  61M     package
  5.7M    support
  148K    system
  732K    toolchain
  436K    utils
  headless @ barge in .../fk-buildroot/output |14:33:22  |tag:2024.02.10 ✓| 
  $ du -sh *
  4.7G    build
  275M    host
  4.0K    images
  124K    target
  headless @ barge in .../output/build |14:33:41  |tag:2024.02.10 ✓| 
  $ du -sh *
  16K     build-time.log
  2.5M    buildroot-config
  331M    glibc-2.38-81-gc8cb4d2b86ece572793e31a3422ea29e88d77df5
  404M    host-binutils-2.40
  46M     host-bison-3.8.2
  18M     host-ccache-4.8.2
  402M    host-cmake-3.28.3
  34M     host-gawk-5.3.0
  1.3G    host-gcc-initial-12.4.0
  31M     host-gmp-6.3.0
  1.3M    host-hiredis-1.2.0
  23M     host-m4-1.4.19
  6.3M    host-mpc-1.2.1
  15M     host-mpfr-4.1.1
  3.5M    host-pkgconf-1.6.3
  8.0K    host-skeleton
  19M     host-zstd-1.5.5
  1.1G    linux-5.10.162-cip24
  1.1G    linux-headers-5.10.162-cip24
  4.0K    skeleton
  12K     skeleton-init-common
  4.0K    skeleton-init-none

headless @ barge in .../_ee/fk-buildroot |14:35:46  |tag:2024.02.10 ?:8 ✗| 
$ tree -h dl/
dl/
|-- [4.0K]  binutils
|   `-- [ 24M]  binutils-2.40.tar.xz
|-- [4.0K]  bison
|   `-- [2.7M]  bison-3.8.2.tar.xz
|-- [4.0K]  ccache
|   `-- [548K]  ccache-4.8.2.tar.xz
|-- [4.0K]  cmake
|   `-- [ 11M]  cmake-3.28.3.tar.gz
|-- [4.0K]  gawk
|   `-- [3.3M]  gawk-5.3.0.tar.xz
|-- [4.0K]  gcc
|   `-- [ 80M]  gcc-12.4.0.tar.xz
|-- [4.0K]  glibc
|   `-- [ 36M]  glibc-2.38-81-gc8cb4d2b86ece572793e31a3422ea29e88d77df5.tar.gz
|-- [4.0K]  gmp
|   `-- [2.0M]  gmp-6.3.0.tar.xz
|-- [4.0K]  hiredis
|   `-- [123K]  hiredis-1.2.0.tar.gz
|-- [4.0K]  linux
|   `-- [177M]  linux-cip-5.10.162-cip24.tar.gz
|-- [4.0K]  m4
|   `-- [1.6M]  m4-1.4.19.tar.xz
|-- [4.0K]  mpc
|   `-- [819K]  mpc-1.2.1.tar.gz
|-- [4.0K]  mpfr
|   `-- [1.4M]  mpfr-4.1.1.tar.xz
|-- [4.0K]  pkgconf
|   `-- [284K]  pkgconf-1.6.3.tar.xz
`-- [4.0K]  zstd
    `-- [2.3M]  zstd-1.5.5.tar.gz


```

- 2）换到40.252-barge-builder容器内


```bash
$ docker run -it --rm barge-builder sh
root@7229e3f69998:/build/buildroot# ls

# disk-clear
root @ deb1013 in .../libvirt/images |14:23:51  
  $ virsh list --all --persistent 
  Id   Name             State
  ---------------------------------
  15   cirros-v063-99   running
  -    rocky-9-131      shut off
  root @ deb1013 in .../libvirt/images |14:23:54  
  $ rm -f  virter:layer:sha256:2e664b790c0fa374c5a4d16cb53a6174683d9f351fc301c59502f54847070aff
  root @ deb1013 in .../libvirt/images |14:24:04  
  $ rm -f virter:work:101 virter:work:2
  virter:work:200         virter:work:200-cidata  virter:work:202         virter:work:202-cidata  
  root @ deb1013 in .../libvirt/images |14:24:04  
  $ rm -f virter:work:101 virter:work:200
root @ deb1013 in .../libvirt/images |14:24:14  
  $ df -h
  Filesystem      Size  Used Avail Use% Mounted on
  overlay          69G   54G   12G  83% / ######12G

root @ deb1013 in /opt/apps |14:31:38  
  $ df -h
  Filesystem      Size  Used Avail Use% Mounted on
  udev             16G     0   16G   0% /dev
  /dev/nvme0n1p2   69G   56G  9.3G  86% / ######9.3G

root @ deb1013 in /opt/apps |14:37:26  
  $ docker images |grep GB
  registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output             v2501                                  b0341c23d821   4 hours ago     1.08GB
  barge-builder                                                                latest                                 b047d6060dd8   4 hours ago     1.41GB ######
  registry.cn-shenzhen.aliyuncs.com/infrasync/gitea-runner-images              ubuntu-20.04                           b669161fe37f   6 months ago    1.28GB

# barge-builder启动进入容器，执行make linux-menuconfig
    7  du -sh ../buildroot/
   11  du -sh /*
   
   15  head -15 /build/configs/kernel.config
   16  cat package/busybox/busybox.config |wc
   17  head -15 package/busybox/busybox.config
   
   #build
   21  apt update
   22  apt install libncurses-dev
   23  make menuconfig
   25  make linux-menuconfig
   #从40.253下载linux-cip源码
   26  cd dl/
   33  cd linux/
   34  wget http://172.29.40.253:8998/dl/linux/linux-cip-5.10.162-cip24.tar.gz
   35  cd ../..
   36  make linux-menuconfig
   38  find /build |wc
   39  find |grep config-k1

root@7229e3f69998:/build/buildroot# make linux-menuconfig
  ##############################
  ... #一堆前置组件编译....


  ##############################
  #
  # configuration written to .config
  #
  make[1]: Leaving directory '/build/buildroot/output/build/linux-5.10.162-cip24'
  >>> linux 5.10.162-cip24 Updating kernel config with fixups
  make[1]: Entering directory '/build/buildroot/output/build/linux-5.10.162-cip24'
  #
  # configuration written to .config
  #
  make[1]: Leaving directory '/build/buildroot/output/build/linux-5.10.162-cip24'
  GIT_DIR=. BR_BINARIES_DIR=/build/buildroot/output/images KCFLAGS=-Wno-attribute-alias PKG_CONFIG_PATH="" /usr/bin/make -j17 -C /build/buildroot/output/build/linux-5.10.162-cip24 HOSTCC="/usr/bin/gcc" HOSTCC="/build/buildroot/output/host/bin/ccache /usr/bin/gcc -O2 -isystem /build/buildroot/output/host/include -L/build/buildroot/output/host/lib -Wl,-rpath,/build/buildroot/output/host/lib" ARCH=x86_64 INSTALL_MOD_PATH=/build/buildroot/output/target CROSS_COMPILE="/build/buildroot/output/host/bin/x86_64-buildroot-linux-gnu-" WERROR=0 REGENERATE_PARSERS=1 DEPMOD=/build/buildroot/output/host/sbin/depmod INSTALL_MOD_STRIP=1 HOSTCC="/usr/bin/gcc" menuconfig                                                                                                                      
  make[1]: Entering directory '/build/buildroot/output/build/linux-5.10.162-cip24'
    UPD     scripts/kconfig/mconf-cfg
    HOSTCC  scripts/kconfig/mconf.o
    HOSTCC  scripts/kconfig/lxdialog/checklist.o
    HOSTCC  scripts/kconfig/lxdialog/inputbox.o
    HOSTCC  scripts/kconfig/lxdialog/menubox.o
    HOSTCC  scripts/kconfig/lxdialog/textbox.o
    HOSTCC  scripts/kconfig/lxdialog/util.o
    HOSTCC  scripts/kconfig/lxdialog/yesno.o
    HOSTLD  scripts/kconfig/mconf
  No change to .config-k1

  *** End of the configuration.
  *** Execute 'make' to start the build or try 'make help'.

  make[1]: Leaving directory '/build/buildroot/output/build/linux-5.10.162-cip24'
  rm -f /build/buildroot/output/build/linux-5.10.162-cip24/.stamp_{kconfig_fixup_done,configured,built}
  rm -f /build/buildroot/output/build/linux-5.10.162-cip24/.stamp_{target,staging,images}_installed
  >>> linux 5.10.162-cip24 Updating kernel config with fixups
  make[1]: Entering directory '/build/buildroot/output/build/linux-5.10.162-cip24'
  #
  # configuration written to .config
  #
  make[1]: Leaving directory '/build/buildroot/output/build/linux-5.10.162-cip24'


# view
  root@7229e3f69998:/build/buildroot# find /build |wc
  699475  699674 64893962
  root@7229e3f69998:/build/buildroot# find |grep config-k1
  ./output/build/linux-5.10.162-cip24/.config-k1

  root@7229e3f69998:/build/buildroot# ll -h ./output/build/linux-5.10.162-cip24/.config*
  -rw-r--r-- 1 root root 80K Jan 14 06:58 ./output/build/linux-5.10.162-cip24/.config
  -rw-r--r-- 1 root root 80K Jan 14 06:57 ./output/build/linux-5.10.162-cip24/.config-k1
  -rw-r--r-- 1 root root 80K Jan 14 06:58 ./output/build/linux-5.10.162-cip24/.config.old
  root@7229e3f69998:/build/buildroot# ll  ./output/build/linux-5.10.162-cip24/.config*
  -rw-r--r-- 1 root root 81463 Jan 14 06:58 ./output/build/linux-5.10.162-cip24/.config
  -rw-r--r-- 1 root root 81463 Jan 14 06:57 ./output/build/linux-5.10.162-cip24/.config-k1

# busybox-menuconfig
# https://www.busybox.net/downloads/busybox-1.36.1.tar.bz2
  root@7229e3f69998:/build/buildroot# make busybox-menuconfig
  >>> busybox 1.36.1 Downloading
  wget --passive-ftp -nd -t 3 -O '/build/buildroot/output/build/.busybox-1.36.1.tar.bz2.MInxqx/output' 'https://www.busybox.net/downloads/busybox-1.36.1.tar.bz2' 
  --2025-01-14 07:09:33--  https://www.busybox.net/downloads/busybox-1.36.1.tar.bz2
  Resolving www.busybox.net (www.busybox.net)... 140.211.167.122
  Connecting to www.busybox.net (www.busybox.net)|140.211.167.122|:443... connected.
  HTTP request sent, awaiting response... 200 OK
  Length: 2525473 (2.4M) [application/x-bzip2]
  Saving to: '/build/buildroot/output/build/.busybox-1.36.1.tar.bz2.MInxqx/output'

  # view
  root@7229e3f69998:/build/buildroot# find |grep config-bb1
  ./output/build/busybox-1.36.1/.config-bb1.old
  ./output/build/busybox-1.36.1/.config-bb1
  root@7229e3f69998:/build/buildroot# ll ./output/build/busybox-1.36.1/.config*
  -rw-r--r-- 1 root root 33342 Jan 14 07:22 ./output/build/busybox-1.36.1/.config
  -rw-r--r-- 1 root root 33342 Jan 14 07:22 ./output/build/busybox-1.36.1/.config-bb1
  -rw-r--r-- 1 root root 33342 Jan 14 07:22 ./output/build/busybox-1.36.1/.config-bb1.old
  -rw-r--r-- 1 root root 33342 Jan 14 07:22 ./output/build/busybox-1.36.1/.config.old
  root@7229e3f69998:/build/buildroot# ll ./output/build/busybox-1.36.1/.config* -h
  -rw-r--r-- 1 root root 33K Jan 14 07:22 ./output/build/busybox-1.36.1/.config
  -rw-r--r-- 1 root root 33K Jan 14 07:22 ./output/build/busybox-1.36.1/.config-bb1

# dl-view
  root@7229e3f69998:/build/buildroot/dl# du -sh ../dl/
  388M	../dl/
  root@7229e3f69998:/build/buildroot/dl# ls -lh  linux/* busybox/*  
  -rw-r--r-- 1 root root 2.5M Jan 14 07:10 busybox/busybox-1.36.1.tar.bz2
  -rw-r--r-- 1 root root 178M Jan 14 05:23 linux/linux-cip-5.10.162-cip24.tar.gz
  root@7229e3f69998:/build/buildroot/dl# du -sh *
  1.4M	autoconf
  668K	autoconf-archive
  1.6M	automake
  25M	binutils
  2.7M	bison
  2.5M	busybox
  552K	ccache
  11M	cmake
  480K	expat
  1.4M	flex
  3.3M	gawk
  80M	gcc
  11M	gettext-tiny
  37M	glibc
  2.1M	gmp
  128K	hiredis
  1.4M	libffi
  956K	libtool
  1.3M	libzlib
  178M	linux
  1.6M	m4
  824K	mpc
  1.4M	mpfr
  292K	pkgconf
  20M	python3
  4.2M	tar
  2.3M	zstd
# dl-view @40.253-vmbarge ##对比; making满盘(有linux,无busybox)
# /_ext/working/_ee/fk-buildroot/dl
  headless @ barge in .../fk-buildroot/dl |15:42:38  |tag:2024.02.10 ?:9 ✗| 
  $ du -sh ../dl/
  343M    ../dl/
  headless @ barge in .../fk-buildroot/dl |15:42:45  |tag:2024.02.10 ?:9 ✗| 
  $ du -sh *
  25M     binutils
  2.7M    bison
  552K    ccache
  11M     cmake
  3.3M    gawk
  80M     gcc
  37M     glibc
  2.1M    gmp
  128K    hiredis
  178M    linux
  1.6M    m4
  824K    mpc
  1.4M    mpfr
  292K    pkgconf
  2.3M    zstd

# build.output
  $ docker pull registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:v2501
  $ docker run -it --rm -v /_ext:/_ext registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:v2501 sh
  / # cp -a /output/ _ext/barge_output3
  / # 
  root @ deb1013 in /opt/apps |16:53:16  
  $ cd /_ext/barge_output3/
  $ ls -lh
  total 1021M
  -rw-r--r-- 1 root root  48M Jan 14 16:46 barge.iso
  -rw-r--r-- 1 root root 925M Jan 14 16:47 brdata.tar.gz
  -rw-r--r-- 1 root root 3.2M Jan 14 16:42 bzImage
  -rw-r--r-- 1 root root  46M Jan 14 16:45 rootfs.tar.xz
```


- 3）换回40.253-vmbarge,直接在linux/busybox源码仓执行

```bash
# 直接解压kernel源码，目录内执行menuconfig; 可行 ################################
headless @ barge in .../unpack1/linux-cip-5.10.162-cip24 |14:40:16  |tag:2024.02.10 ?:8 ✗| 
$ history |tail -15
 4618  2025-01-14 14:35:49 tree -h dl/
 4619  2025-01-14 14:39:22 cd dl/linux/
 4620  2025-01-14 14:39:26 mkdir unpack1
 4621  2025-01-14 14:39:35 tar -zxf linux-cip-5.10.162-cip24.tar.gz -C unpack1/
 4622  2025-01-14 14:39:44 cd unpack1/linux-cip-5.10.162-cip24/
 4623  2025-01-14 14:39:45 ll
 4624  2025-01-14 14:39:57 make menuconfig
headless @ barge in .../unpack1/linux-cip-5.10.162-cip24 |14:39:45  |tag:2024.02.10 ?:8 ✗| 
$ make menuconfig
  HOSTCC  scripts/basic/fixdep
  UPD     scripts/kconfig/mconf-cfg
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/lxdialog/checklist.o
  HOSTCC  scripts/kconfig/lxdialog/inputbox.o
  HOSTCC  scripts/kconfig/lxdialog/menubox.o
  HOSTCC  scripts/kconfig/lxdialog/textbox.o
  HOSTCC  scripts/kconfig/lxdialog/util.o
  HOSTCC  scripts/kconfig/lxdialog/yesno.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/mconf
#
# using defaults found in arch/x86/configs/x86_64_defconfig
#
configuration written to .config
*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.


# linux/busybox#################
headless @ barge in .../_diy_menuconfig/linux-cip-5.10.162-cip24 |17:07:51  |tag:2024.02.10 ?:9 ✗| 
$ sz .config-k2 
headless @ barge in .../_diy_menuconfig/linux-cip-5.10.162-cip24 |17:08:10  |tag:2024.02.10 ?:9 ✗| 
$ history |tail -30
 4785  2025-01-14 15:42:25 mkdir ../../../_diy_menuconfig
 4786  2025-01-14 15:42:31 mv linux-cip-5.10.162-cip24/ ../../../_diy_menuconfig/
 4796  2025-01-14 15:45:03 cd /_ext/working/_ee/fk-buildroot/_diy_menuconfig
 #busybox
 4797  2025-01-14 15:45:05 rz
 4798  2025-01-14 15:45:40 tar -jxf busybox-1.36.1.tar.bz2 
 4799  2025-01-14 15:45:47 cd busybox-1.36.1
 4800  2025-01-14 15:46:03 ll 
 4802  2025-01-14 17:03:12 cat 00busybox.config > .config
 4805  2025-01-14 17:04:37 sz .config-bb2
 #linux
 4806  2025-01-14 17:05:21 cd ../linux-cip-5.10.162-cip24/
 4807  2025-01-14 17:05:25 rz -E
 4808  2025-01-14 17:05:29 ll
 4809  2025-01-14 17:05:35 cp 00kernel.config .config 
 4810  2025-01-14 17:05:43 cat 00kernel.config > .config 
 4811  2025-01-14 17:06:09 make menuconfig
 4812  2025-01-14 17:07:51 ll -a
 4813  2025-01-14 17:08:01 sz .config-k2
```