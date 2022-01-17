#!/bin/bash
mkdir -p lfs/sources
export LFS=$(pwd)/lfs
chmod -v a+wt $LFS/sources
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
pushd $LFS/sources
md5sum -c ../../md5sums
popd
cd $LFS
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
for i in bin lib sbin; do
ln -sv usr/$i $LFS/$i
done
case $(uname -m) in
x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/tools
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
x86_64) chown -v lfs $LFS/lib64 ;;
esac
chown -v lfs $LFS/sources

