# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpgp/libkpgp-4.1.3.ebuild,v 1.1 2008/11/09 00:41:44 scarabeus Exp $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="KDE pgp abstraction library"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

KMEXTRACTONLY="kdepim-compat.h"
