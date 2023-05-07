#!/bin/sh
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

REPO=https://gitee.com/infrastlabs/k8s-kubeedge-iot
# curl -k -fSL $REPO/raw/dev/virter/barge-init.sh |bash -
# wget -qO- $REPO/raw/dev/virter/barge-init.sh |bash -
f1=/tmp/bInit.sh
echo "doInit:"
while true; do
  echo -n "."
  wget --timeout=5 --tries=1 -qO- $REPO/raw/dev/virter/barge-init.sh > $f1
  match1=$(cat $f1 |grep "function kedgeInit")
  if [ ! -z "$match1" ]; then
    cat $f1 |bash -
    break
  fi
  sleep 1 #1.1 err: only num@barge
done
