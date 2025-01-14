
config/_diy_menuconfig (sam-custom)
$ find |sort
./00kernel.config #原barge-os//configs/下配置 {4.14.125 Kernel, bbox 1.31.0}
./00busybox.config 
./linux_kernel/.config-k1 #40.252/barge-builder启容器后,/build/buildroot下执行make linux-menuconfig更新
./linux_kernel/.config-k2 #40.253/vmbarge-headless环境下，解压src包执行make menuconfig更新 [diff:gcc不一样，用的本地环境的]
./busybox_v136/.config-bb1 
./busybox_v136/.config-bb2 #[diff:无 仅top生成时间不同]
