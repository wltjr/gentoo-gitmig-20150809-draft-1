# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.33.3.ebuild,v 1.3 2007/01/18 12:56:46 gustavoz Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm m68k ppc sh sparc x86"
inherit eutils kernel-2
detect_version

PATCHES_V="1"

SRC_URI="${KERNEL_URI} mirror://gentoo/gentoo-headers-${OKV}-${PATCHES_V}.tar.bz2"

KEYWORDS="-* ~alpha -amd64 ~arm ~hppa ~ia64 ~m68k -mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gcc64"

DEPEND="sparc? ( gcc64? ( sys-devel/kgcc64 ) )"

UNIPATCH_LIST="${DISTDIR}/gentoo-headers-${OKV}-${PATCHES_V}.tar.bz2"
