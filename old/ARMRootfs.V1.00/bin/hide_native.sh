#!/bin/sh
# �ؼ�����1. ROOTDIR
ROOTDIR=`(cd ".."; /bin/pwd)`

# �ؼ�����2. PLATFORM
KNOWN_PLATFORM="ti fsl ecs"
for i in $KNOWN_PLATFORM; do
	if [ "$i" = "$1" ]; then
		PLAT_ALIAS=$1
		break;
	fi;
done;
if [ -z $PLAT_ALIAS ]; then
	echo "Usage:	./build_all.sh [Platform-alias]"
	echo "All Known platform aliases are :"
	echo "    $KNOWN_PLATFORM"
	exit;
fi;
PLATFORM=arm-$PLAT_ALIAS
echo "======TO BUILD: $PLATFORM"

# �ؼ�����3:
SRCDIR=/home/baiyun/Packages
BINDIR=$ROOTDIR/bin
CACHEDIR=$ROOTDIR/cache/$PLATFORM
TEMPDIR=$ROOTDIR/temp
DLDIR=$SRCDIR		# Ϊutil.sh�ű��еļ�����ʹ��
INCDIR=$ROOTDIR/include
DISTDIR=$ROOTDIR/dist/$PLATFORM
SDKDIR=$DISTDIR/sdk
BOOTDIR=$DISTDIR/boot
INSTDIR=$DISTDIR/rootfs
PATCHDIR=$ROOTDIR/patch
BUILDINDIR=$PATCHDIR/buildin/$PLATFORM

initenv()
{
echo
}

source ./utils.sh
hide_native0

