# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-oss/gst-plugins-oss-0.8.5.ebuild,v 1.10 2005/01/22 06:36:39 vapier Exp $

inherit gst-plugins

KEYWORDS="x86 alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc"
IUSE=""

# should we depend on a kernel (?)
DEPEND="virtual/os-headers"
