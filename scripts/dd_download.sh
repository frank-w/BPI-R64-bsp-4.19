#!/bin/sh

# make partition table by fdisk command
# reserve part for fex binaries download 0~204799
# partition1 /dev/sdc1 vfat 204800~327679
# partition2 /dev/sdc2 ext4 327680~end

die() {
        echo "$*" >&2
        exit 1
}

[ $# -eq 1 ] || die "Usage: $0 /dev/sdc"

[ -s "./env.sh" ] || die "please run ./configure first."

. ./env.sh

O=$1
#PRELOADER=$TOPDIR/mt-pack/mtk/${TARGET_PRODUCT}/bin/preloader_iotg7623Np1_emmc.bin
#UBOOT=$TOPDIR/u-boot-mt/u-boot.bin

#PRELOADER=$TOPDIR/mt-pack/mtk/${TARGET_PRODUCT}/bin/preloader_evb7622_64_forsdcard-2k.img
PRELOADER=$TOPDIR/mt-pack/mtk/${TARGET_PRODUCT}/bin/preloader_bpi-r64_forsdcard-2k.img
ATF=$TOPDIR/mt-pack/mtk/${TARGET_PRODUCT}/bin/BPI-R64-atf.img
UBOOT=$TOPDIR/u-boot-mt/u-boot-mtk.bin


#
HEAD0=$TOPDIR/mt-pack/mtk/${TARGET_PRODUCT}/bin/BPI-R2-HEAD440-0k.img
HEAD1=$TOPDIR/mt-pack/mtk/${TARGET_PRODUCT}/bin/BPI-R2-HEAD1-512b.img
#
sudo dd if=$HEAD0 	of=$O bs=512 seek=0
sudo dd if=$HEAD1 	of=$O bs=512 seek=1

sudo dd if=$PRELOADER 	of=$O bs=1k seek=2

sudo dd if=$ATF 	of=$O bs=1k seek=512

sudo dd if=$UBOOT 	of=$O bs=1k seek=768

