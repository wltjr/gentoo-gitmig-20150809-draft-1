# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.19-r3.ebuild,v 1.1 2002/05/06 22:45:04 drobbins Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=2.4.18
KV=2.4.19-gentoo-r3
S=${WORKDIR}/linux-${KV}
ETYPE="sources"

# What's in this kernel?

# INCLUDED:
#	from http://www.kernel.org (ac):
#		2.4.19-pre7-ac2
#		removed the software suspend patch; it can be dangerous and
#		conflicts with the new ACPI
#	from http://oss.sgi.com/projects/xfs:
#		SGI XFS 1.1 (Official release code -- the most thoroughly tested)
#	from http://www.grsecurity.org:
#		grsecurity-1.9.4 (with 2 updates/fixes and a fix for an NVIDIA driver compile problem)
#	from http://www.zipworld.com.au/~akpm/linux/schedlat.html:
#   	2.4.19-pre7-low-latency
#	from http://luxik.cdi.cz/~devik/qos/htb/:
#   	htb2 (QoS support)
#	from http://www.tech9.net/rml/linux:
#   	preempt-kernel-rml-2.4.19-pre7-ac2-1.patch
#		preempt-stats-rml-2.4.19-pre5-ac3-1.patch
#	from Daniel Robbins:
#		i386 1000 HZ patch (trivial; jp also has a one-line patch for this one) 
#	from http://www.infolinux.de/jp10:
#		40_TIOCGDEV.bz2
#		51_loop-jari-2.4.16.0.bz2
#		98_tkparse-4096.bz2
#	from http://www.kernel.org (aa):
#		00_3.5G-address-space-4
#	from http://www.sourceforge.net/projects/acpi:
#		acpi-20020404-2.4.18.diff.gz
#		(This allows booting of Toshiba Satellite 5005-S507 "legacy free" laptops)
#	from Blue Lizard <webmaster at dofty.zzn.com>:
#		A 2-line patch to enable compatibility with the new SiS 740/961 Athlon chipset

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2  http://www.ibiblio.org/gentoo/distfiles/linux-gentoo-${KV}.patch.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 sys-devel/perl >=sys-apps/modutils-2.4.2 sys-devel/make"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	cd ${S}
	cat ${DISTDIR}/linux-gentoo-${KV}.patch.bz2 | bzip2 -d | patch -p1 || die
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#this file is required for other things to build properly, so we autogenerate it
	make include/linux/version.h || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig
}

src_compile() {
	if [ "$ETYPE" = "headers" ]
	then
		yes "" | make oldconfig		
		echo "Ignore any errors from the yes command above."
	fi
}

src_install() {
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		rm -rf ${D}/usr/include/linux/modules
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
}

pkg_preinst() {
	if [ "$ETYPE" = "headers" ] 
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${KV} ${ROOT}/usr/src/linux
	fi
}
