
**Tags**

- v282-rpi @18.5.8  #`branch: rpi`
- v280-rpi @18.3.10
- v274.1-rpi @18.1.20
- v262.2-rpi-arm64v8 @17.11.25 #`branch: rpi-arm64`
- v262.1-rpi @17.10.31
- v260-rpi-arm64v8 @17.9.6
- v254-rpi-arm64v8 @17.7.14
- ...
- v222-rpi @16.9.20
- mark-pre-patching @16.1.23
- init @15.8.7

```bash
# orgRepo-info
  # Releases 148>> 2.15.0|3.0.0-dev2|2.14.0-rc2 
  # issue: 25+47, pr: 1+39; @25.1.15
  https://github.com/bargees/barge-os/releases

# buildroot.config
# rz _ref\config\_diy_menuconfig\_arm64\00buildroot.config
  headless @ barge in .../_ee/fk-buildroot-20.02 |17:50:10  |tag:2020.02.12 ?:4 ✗| 
  $ mv 00buildroot.config  .config-arm64
  renamed '00buildroot.config' -> '.config-arm64'
  headless @ barge in .../_ee/fk-buildroot-20.02 |17:55:20  |tag:2020.02.12 ?:6 ✗| 
  $ ll
  -rw-r--r--    1 headless headless  81K Jan 15 17:32 .config-arm64
  -rw-r--r--    1 headless headless 108K Jan 15 17:53 .config-arm64-2
  -rw-r--r--    1 headless headless 106K Jan 15 17:55 .config-arm64-21-nolegacy


# multi-BUILD
###cirros###################################################
# gitac 25min: matrix> arch.x4; runs-on: ubuntu-22.04
# gitac> cirros-build-matrix:
#   actions/cache@v4 ./download ./ccache
#   bin/system-setup
#   apt cloud-utils qemu-system openbios-ppc; echo "127.0.0.1 invisible-mirror.net" | sudo tee -a /etc/hosts
#   bin/build-release "$reason"
#   bin/test-boot
#   actions/upload-artifact@v4
  source "${0%/*}/common-functions.sh"
  build_arch() {
    local arch="" quiet=false cmd="" log=""
    if [ "$1" = "quiet" ]; then
        quiet=true
        shift
    fi
    arch="$1"
    log="${OUT}/build-$arch.log"
    cmd=( make $MAKE_QUIET ARCH=$arch "OUT_D=$OUT/build/$arch"
          ${CCACHE_D:+"BR2_CCACHE_DIR=${CCACHE_D}/$arch"} )

    logevent "start $arch" -
    if $quiet; then
        error "building $arch into $log"
        time "${cmd[@]}" > "$log" 2>&1
    else
        time "${cmd[@]}" 2>&1 | tee "$log"
    fi
  # STAGE 2: BUILD
  jobs_flag=""
  parallel=true
  case "${CIRROS_PARALLEL:-none}" in
      none) parallel=false;;
      0|true) :;;
      [0-9]|[0-9][0-9]) jobs_flag="--jobs=${CIRROS_PARALLEL}";;
      auto) command -v parallel >/dev/null || parallel=false;;
      *) fail "unknown value for CIRROS_PARALLEL=$CIRROS_PARALLEL";;
  esac
  if $parallel; then
      parallel --ungroup ${jobs_flag} \
          "$0" "$VER" build_arch quiet {} ::: ${ARCHES}
  else
      for arch in ${ARCHES}; do
          build_arch "$arch"
      done;
  fi


###fogproject-fos############################################################
# gitac: 1h8min; check---x4---publish; runs-on: ubuntu-22.04
# gitac:create_release.yaml> /build.sh > /dependencies.sh
  ./build.sh --install-dep -nfa arm64
  ./build.sh --install-dep -nka x86
  ./build.sh --install-dep -nka x64
  # 
  ./build.sh --install-dep -nfa arm64
  ./build.sh --install-dep -nfa x86
  ./build.sh --install-dep -nfa x64

  # buildFs: buildroot-$BUILDROOT_VERSION.tar.xz> patches> make oldconfig> make menuconfig> make;
    case "${arch}" in
        x64)
            make >buildroot$arch.log 2>&1
            ;;
        x86)
            make ARCH=i486 >buildroot$arch.log 2>&1
            ;;
        arm64)
            make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-gnu- >buildroot$arch.log 2>&1
            ;;
  # buildKernel: linux-$KERNEL_VERSION.tar.xz> linux-firmware> make mrproper,patches> make config> make -j $(nproc);
    case "${arch}" in
        x64)
            make oldconfig
            make -j $(nproc) bzImage
            ;;
        x86)
            make ARCH=i386 oldconfig
            make ARCH=i386 -j $(nproc) bzImage
            ;;
        arm64)
            make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- oldconfig
            make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j $(nproc) Image
            ;;

  # entry
  for buildArch in $arch
  do
      if [[ -z $buildKernelOnly ]]; then
          buildFilesystem $buildArch
      fi
      if [[ -z $buildFSOnly ]]; then
          buildKernel $buildArch
      fi
```

- try1

```bash
###############
root @ deb1013 in .../_ee/fk-barge-os |07:30:32  |sam-custom ✓| 
$ git pull; docker build -t b2 .
$ docker run -it --rm b2

# ref Makefile
# docker run --privileged -v $(DL_DIR):/build/buildroot/dl \
# 			-v $(CCACHE_DIR):/build/buildroot/ccache --name $(BUILD_CONTAINER) $(BUILD_IMAGE);
```




