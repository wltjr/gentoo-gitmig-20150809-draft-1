# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtd-utils/mtd-utils-1.5.0.ebuild,v 1.2 2012/08/03 16:00:33 ago Exp $

EAPI="3"

inherit eutils vcs-snapshot

if [[ ${PV} == "99999999" ]] ; then
	EGIT_REPO_URI="git://git.infradead.org/mtd-utils.git"

	inherit git
	SRC_URI=""
	#KEYWORDS=""
else
	if [[ ${PV} == *.*.* ]] ; then
		MY_PV="${PV}-*"
		SRC_URI="http://git.infradead.org/mtd-utils.git/snapshot/v${PV}.tar.gz -> ${P}.tar.gz"
	else
		MY_PV="${PV}-02ae0aac87576d07202a62d11294ea55b56f450b"
		SRC_URI="mirror://gentoo/${PN}-snapshot-${MY_PV}.tar.xz"
	fi
	KEYWORDS="amd64 ~arm ~mips ~ppc ~x86 ~amd64-linux ~x86-linux"
fi

DESCRIPTION="MTD userspace tools (NFTL, JFFS2, NAND, FTL, UBI)"
HOMEPAGE="http://git.infradead.org/?p=mtd-utils.git;a=summary"

LICENSE="GPL-2"
SLOT="0"
IUSE="xattr"

# We need libuuid
RDEPEND="!sys-fs/mtd
	dev-libs/lzo
	sys-libs/zlib
	>=sys-apps/util-linux-2.16"
# ACL is only required for the <sys/acl.h> header file to build mkfs.jffs2
# And ACL brings in Attr as well.
DEPEND="${RDEPEND}
	xattr? ( sys-apps/acl )"

makeopts() {
	echo CROSS=${CHOST}-
	use xattr || echo WITHOUT_XATTR=1
}

src_compile() {
	emake $(makeopts) || die
}

src_install() {
	emake $(makeopts) install DESTDIR="${ED}" || die
	dodoc *.txt
	newdoc mkfs.ubifs/README README.mkfs.ubifs
	# TODO: check ubi-utils for docs+scripts
}
