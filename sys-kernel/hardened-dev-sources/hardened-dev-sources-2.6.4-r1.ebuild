# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-dev-sources/hardened-dev-sources-2.6.4-r1.ebuild,v 1.1 2004/03/20 05:01:49 tseng Exp $

ETYPE="sources"
inherit kernel-2
detect_version

#version of hardened gentoo patchset
HGPV=4.1
HGPV_SRC="http://dev.gentoo.org/~tseng/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"

UNIPATCH_LIST="${DISTDIR}/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}.tar.bz2"
UNIPATCH_DOCS="${WORKDIR}/patches/hardened-patches-${KV_MAJOR}.${KV_MINOR}-${HGPV}/0000_README"

DESCRIPTION="Hardened sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${HGPV_SRC}"
KEYWORDS="~x86 ~ppc ~sparc ~alpha -hppa"

pkg_postinst() {
	postinst_sources
}
