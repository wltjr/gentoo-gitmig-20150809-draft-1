# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-suite/geda-suite-20110427.ebuild,v 1.1 2011/04/30 06:23:55 tomjbe Exp $

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="Metapackage which installs all the components required for a full-featured gEDA/gaf system"

IUSE=''
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="sci-electronics/geda
	sci-electronics/gerbv
	>=sci-electronics/gnucap-0.35.20091207
	>=sci-electronics/gwave-20090213-r1
	>=sci-electronics/pcb-20100929
	>=sci-electronics/geda-xgsch2pcb-0.1.3-r2
	>=sci-electronics/iverilog-0.9.1
	>=sci-electronics/ng-spice-rework-21
	sci-electronics/gspiceui
	>=sci-electronics/gnetman-0.0.1_pre20060522-r2
	sci-electronics/gtkwave"
