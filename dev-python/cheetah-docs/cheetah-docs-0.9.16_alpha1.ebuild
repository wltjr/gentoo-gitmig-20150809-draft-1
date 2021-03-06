# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah-docs/cheetah-docs-0.9.16_alpha1.ebuild,v 1.10 2015/03/21 11:51:35 jlec Exp $

EAPI=5

inherit eutils

DESCRIPTION="Documentation for Cheetah templates"
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/CheetahDocs-${PV/_alpha/a}.tgz"

IUSE=""
LICENSE="OPL"
KEYWORDS="~amd64 ~ia64 ppc x86"
SLOT="0"

S=${WORKDIR}/CheetahDocs

RESTRICT="binchecks strip"

src_install() {
	ecvs_clean

	dodoc *.txt TODO
	dohtml -r devel_guide_html devel_guide_html_multipage \
		users_guide_html users_guide_html_multipage \
		OnePageTutorial.html

	# Install the source code.
	insinto /usr/share/doc/${PF}
	doins -r devel_guide_src users_guide_src

	doins *.ps *.pdf
}
