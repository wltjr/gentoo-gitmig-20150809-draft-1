# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktimetracker/ktimetracker-4.2.0.ebuild,v 1.1 2009/01/27 17:57:16 alexxy Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KTimeTracker tracks time spent on various tasks."
IUSE="debug"
KEYWORDS="~amd64 ~x86"

DEPEND="kde-base/kontact:${SLOT}
	kde-base/kdepim-kresources:${SLOT}
	kde-base/libkdepim:${SLOT}"

KMEXTRACTONLY="kresources
	libkdepim"
KMLOADLIBS="libkdepim
	kontactinterfaces"
