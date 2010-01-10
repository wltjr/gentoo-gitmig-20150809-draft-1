# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gnu-efi/gnu-efi-3.0i.ebuild,v 1.1 2010/01/10 16:34:24 armin76 Exp $

inherit eutils toolchain-funcs

MY_P="${PN}_${PV}"

DESCRIPTION="Library for build EFI Applications"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="mirror://sourceforge/gnu-efi/${MY_P}.orig.tar.gz"
SRC_URI="${SRC_URI} mirror://debian/pool/main/g/gnu-efi/gnu-efi_3.0i-2.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	ebegin Applying ../*.diff
	# Using epatch on this is annoying because it wants to create the elilo-3.6/
	# directory.  Since all the files are new, it doesn't know better.
	filterdiff -p1 -i debian/\* ../*.diff | patch -s -p1
	eend $? || return
}

src_compile() {
	local iarch
	case $ARCH in
		ia64)  iarch=ia64 ;;
		x86)   iarch=ia32 ;;
		amd64) iarch=x86_64 ;;
		*)    die "unknown architecture: $ARCH" ;;
	esac
	emake CC="$(tc-getCC)" ARCH=${iarch} -j1 || die "emake failed"
}

src_install() {
	make install INSTALLROOT="${D}"/usr || die "install failed"
	dodoc README* ChangeLog
}
