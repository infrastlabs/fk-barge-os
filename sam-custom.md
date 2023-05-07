**Flow**

- gitac:
- make> Dockerfile
- imgbuild.sh> Dockerfile.output
- 
- handBuild(reView)
- barge-x: contrib/update-docker: make
- 
- qcow2
- fk-barge-packer//qumu

**barge-packer:qcow2**

```bash
https://gitee.com/g-system/fk-barge-packer/tree/sam-custom/qemu
https://gitee.com/g-system/fk-barge-packer/blob/sam-custom/sam-custom.md


```


**handBuild,barge-x-build**

```bash
# 2023-handBuild:
headless @ mac23-199 in .../_tea/fk-barge-os |11:58:32  |sam-custom ✓| 
$ pwd
/_ext/working/_tea/fk-barge-os
headless @ mac23-199 in .../_tea/fk-barge-os |11:58:27  |sam-custom ✓| 
$ ll output/
total 41M
-rw-r--r-- 1 headless headless  14M May  7 01:55 barge.img
-rw-r--r-- 1 headless headless  14M May  7 18:28 barge.iso
-rw-r--r-- 1 headless headless 2.7M May  7 18:27 bzImage
-rw-r--r-- 1 headless headless  11M May  7 18:27 rootfs.tar.xz

# gitac> packImg_output
headless @ mac23-199 in ~ |12:55:35  
$ docker  run -it --rm registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:latest sh
/ # find output/
output/
output/barge.iso
output/brdata.tar.gz
output/bzImage
output/rootfs.tar.xz



# repack: barge-x.iso
#  make
#  imgbuild.sh
headless @ mac23-199 in .../_tea/fk-barge-os-ee |13:07:13  |sam-custom ?:6 ✗| 
$ cd contrib/update-docker/
/_ext/working/_tea/fk-barge-os-ee/contrib/update-docker
# registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v212-org
# registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214

# ten-vm2:
root@VM-12-9-ubuntu:~# docker run -it --rm -v $(pwd):/mnt registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214 sh -c "\cp /output/barge-x.iso /mnt/"
Unable to find image 'registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214' locally
v214: Pulling from infrastlabs/barge-build-output-x
72cfd02ff4d0: Already exists 
16d04239bbeb: Pull complete 
Digest: sha256:6f918b79dd126fdd6823f2ee4b67430d03c890efd2c123a85c5d8db3c3d50fd0
Status: Downloaded newer image for registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214
root@VM-12-9-ubuntu:~# ll barge-x.iso 
-rw-r--r-- 1 root root 34603008 May 28 13:10 barge-x.iso
root@VM-12-9-ubuntu:~# python -m http.server 8998
Serving HTTP on 0.0.0.0 port 8998 (http://0.0.0.0:8998/) ...

root@VM-12-9-ubuntu:~# ver=v214-19.03.15; docker run -it --rm -v $(pwd):/mnt registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:$ver sh -c "\cp /output/barge-x.iso /mnt/barge-x-$ver.iso"
Unable to find image 'registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214-19.03.15' locally
v214-19.03.15: Pulling from infrastlabs/barge-build-output-x
72cfd02ff4d0: Already exists 
0681154e8eea: Pull complete 
Digest: sha256:7439c06535859be23d7c1c8730c861dd2a885cc7b3e9bf651930491ccf7a7d4d
Status: Downloaded newer image for registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214-19.03.15
root@VM-12-9-ubuntu:~# ll barge-x* -lh
-rw-r--r-- 1 root root 33M May 28 13:10 barge-x.iso
-rw-r--r-- 1 root root 41M May 28 13:40 barge-x-v214-19.03.15.iso

root@VM-12-9-ubuntu:~# ver=v214-17.12.1-ce; docker run -it --rm -v $(pwd):/mnt registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:$ver sh -c "\cp /output/barge-x.iso /mnt/barge-x-$ver.iso"
Unable to find image 'registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214-17.12.1-ce' locally
v214-17.12.1-ce: Pulling from infrastlabs/barge-build-output-x
72cfd02ff4d0: Already exists 
dcfc78588777: Pull complete 
Digest: sha256:db264a71dcf3944b57d6cd8debff14d21e6a2e80bb8547f2de0ae418b7eee218
Status: Downloaded newer image for registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output-x:v214-17.12.1-ce
root@VM-12-9-ubuntu:~# ll barge-x* -lh
-rw-r--r-- 1 root root 33M May 28 13:10 barge-x.iso
-rw-r--r-- 1 root root 25M May 28 13:42 barge-x-v214-17.12.1-ce.iso
-rw-r--r-- 1 root root 41M May 28 13:40 barge-x-v214-19.03.15.iso
# py 8998> gemmi_down> vboxTested OK;


# barge-x.iso>> barge-x.qcow2:
>>https://gitee.com/g-system/fk-barge-packer/blob/sam-custom/sam-custom.md
```

**Items,Use**

- gitac: build barge.iso> `qcowImg> dcp-kvm-virter{libvirtd_x1: kvm_x20> ctKedge_x20}`
- start.sh: curl `gitee/k3-kedge-iot/virter/barge-init.sh` |bash -
  - dcp init: docker run $img sh -c "cp out"
  - kedge init: docker run $kcmd sh -c "git clone "
  - dcp up kedge --scale=$INST_KEDGE -d
- virter,qcow2
  - virter_kvm_env: INST_KEDGE
  - qcow2_img: 40G_100G? > virter+dataImg(preGenerate);

```bash
# Putting any scripts in the /etc/init.d/S* in the SysV manner.
# Barge's init executes /etc/init.d/init.sh right after mounting the disk and before /etc/init.d scripts including networking.
# Barge's init executes /etc/init.d/start.sh asynchronously right after executing /etc/init.d scripts.

# headless @ mac23-199 in .../_ct/fk-docker-libvirtd |09:07:15  |sam-custom _30 _| 
/_ext/working/_ct/fk-docker-libvirtd
$ git pull; sh imgbuild.sh

# github ac: build iso

# packer-diskimage
headless @ mac23-199 in .../fk-barge-packer/qemu |09:11:35  |sam-custom ?:2 _| 
$ pwd
/_ext/working/_ct/fk-barge-packer/qemu
$ git pull; bash _prepare_dcp_up.sh
Successfully built 6d3f60d41987
Successfully tagged registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-diskimage:latest

```

**barge-x**

- prs:3000/g-dev1/mods-infrast/src/branch/dev/docker-static
- https://docs.docker.com/compose/compose-file/compose-versioning/

```bash
# https://download.docker.com/linux/static/stable/x86_64/
docker-17.03.2-ce.tgz  2020-08-04 21:57:13 26.5 MiB
docker-17.12.1-ce.tgz  2020-08-04 23:42:56 32.7 MiB ######
docker-18.03.1-ce.tgz  2020-08-04 23:42:58 37.0 MiB ##
docker-18.06.3-ce.tgz  2020-08-04 23:43:09 41.8 MiB
docker-18.09.3.tgz     2020-08-04 23:43:12 45.8 MiB ##
docker-18.09.8.tgz     2020-08-04 23:43:17 45.8 MiB
docker-18.09.9.tgz     2020-08-04 23:43:23 53.7 MiB
docker-19.03.9.tgz     2020-08-04 23:43:40 57.9 MiB
docker-19.03.15.tgz    2021-03-02 20:51:12 59.5 MiB ######
docker-20.10.24.tgz    2023-04-04 21:19:24 63.9 MiB
docker-23.0.6.tgz      2023-05-11 08:44:23 63.9 MiB
docker-24.0.2.tgz      2023-05-26 08:04:24 66.4 MiB
# https://download.docker.com/linux/static/stable/aarch64/
docker-17.12.1-ce.tgz  2020-08-04 23:40:26 29.4 MiB ######
docker-18.03.1-ce.tgz  2020-08-04 23:40:27 33.3 MiB
docker-18.06.3-ce.tgz  2020-08-04 23:40:30 38.6 MiB
docker-18.09.3.tgz     2020-08-04 23:40:33 40.9 MiB
docker-18.09.8.tgz     2020-08-04 23:40:38 40.9 MiB
docker-18.09.9.tgz     2020-08-04 23:40:39 47.2 MiB
docker-19.03.9.tgz     2020-08-04 23:40:52 51.2 MiB
docker-19.03.12.tgz    2020-09-17 02:18:41 51.2 MiB
docker-19.03.15.tgz    2021-03-02 20:50:48 52.7 MiB ######
docker-20.10.8.tgz     2021-08-09 18:35:24 52.1 MiB
docker-20.10.14.tgz    2022-03-24 02:48:22 55.1 MiB
docker-20.10.23.tgz    2023-02-09 21:24:18 57.2 MiB
docker-20.10.24.tgz    2023-04-04 21:19:13 57.9 MiB
docker-23.0.6.tgz      2023-05-11 08:44:18 58.3 MiB
docker-24.0.2.tgz      2023-05-26 08:04:14 60.6 MiB
```

- 2.12.0-x@Mar 10, 2019 https://github.com/bargees/barge-os/releases?page=2 docker **v18.09.3** 33 MB; 
- barge-2.8.2-x@May 8, 2018 https://github.com/bargees/barge-os/releases?page=4 docker **v18.03.1-ce** 27 MB; 
- 2.5.1@Jun 8, 2017 https://github.com/bargees/barge-os/releases?page=8 Docker v17.06.0-ce-rc2 13 MB; #启时下载
- 2.1.3@Jun 25, 2016 https://github.com/bargees/barge-os/releases?page=14 pg14; docker 1.10.3 13 MB;

```bash
# @docker-static: 18.09.8: mods-infra//docker-static,multi
# @23.193/23.72-pve: 18.09.6 (dp:docker-only)
# @23.194/195: 19.03.15 (HandReplace)
# https://github.com/moby/moby/releases
#  v24.0.2@May 26, 2023
#  v23.0.6@May 8, 2023
#  v22.06.0-beta.0@Jun 4, 2022 #pg4
#  v20.10.25@May 16, 2023 ##############
#  v19.03.15@Feb 2, 2021 ##############
#  v19.03.14@Dec 2, 2020 #无18.x
#  v17.03.2-ce@Jun 28, 2017
#  v17.03.0-ce-rc1@Feb 21, 2017 #pg7
#  v1.13.1@Feb 9, 2017 #pg7
#  v1.12.6@Jan 11, 2017 #pg8
#  v1.11.2@Jun 2, 2016 #pg11
#  v1.10.3@Mar 11, 2016 #pg12 ######
#  v1.9.1@Nov 21, 2015 #pg13
#  v1.8.0-rc3@Aug 8, 2015 #first pg14


# >>17.12.0+
# https://github.com/docker/docker-ce/releases 
#  v19.03.14@Dec 2, 2020 #last-eof
#  v18.09.9@Sep 5, 2019 #pg3  ##############
#  v18.06.0-ce-rc1@Jun 28, 2018 #pg8
#  v18.03.1-ce@Apr 26, 2018 #pg8
#  v17.12.1-ce@Feb 28, 2018 #?page=9
#  v17.06.0-ce-rc1@May 30, 2017 #first pg13


# https://docs.docker.com/compose/compose-file/compose-versioning/
# 3.8  19.03.0+ # 3.5  17.12.0+ # 3.0  1.13.0+ 
# 
# 2.4  17.12.0+ # 2.3  17.06.0+
# 2.2  1.13.0+  # 2.1  1.12.0+
# 2.0  1.10.0+
# 
# export DOCKER_API_VERSION=1.24 #dcp-go
# export DOCKER_API_VERSION=1.22 #dcp-go @1.10.3

```

**Rebuilding BuildRoot Configs**

```bash
# change-ff2: https://github.com/huapox/barge-os/commits/master #x3 @Oct 5, 2019
#   BUILD_CONTAINER=barge-built #把构建img保存
#   https://github.com/huapox/barge-os/commit/082ebbe63df1844421732a135b68fae32ebd7b8e #sam-ns1/barge-os:src 

# https://github.com/ahmedbodi/barge-os/commit/d40763f7389468fb6ae3acf6ba7b9f01c904f382
git clone https://github.com/buildroot/buildroot buildroot
cp ./barge-os/configs/buildroot.config buildroot/.config
cd buildroot
make menuconfig <- make any changes, remove old config settings then copy it back to barge-os
cd ../barge-os
make
```

