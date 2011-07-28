# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-4.7.0-r1.ebuild,v 1.1 2011/07/28 21:31:04 dilfridge Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="nls"

RDEPEND="
	$(add_kdebase_dep akonadiconsole)
	$(add_kdebase_dep akregator)
	$(add_kdebase_dep blogilo)
	$(add_kdebase_dep kabcclient)
	$(add_kdebase_dep kaddressbook)
	$(add_kdebase_dep kalarm)
	$(add_kdebase_dep kdepim-icons)
	$(add_kdebase_dep kdepim-kresources)
	$(add_kdebase_dep kdepim-runtime)
	$(add_kdebase_dep kdepim-strigi-analyzer)
	$(add_kdebase_dep kdepim-wizards)
	$(add_kdebase_dep kjots)
	$(add_kdebase_dep kleopatra)
	$(add_kdebase_dep kmail)
	$(add_kdebase_dep knode)
	$(add_kdebase_dep knotes)
	$(add_kdebase_dep konsolekalendar)
	$(add_kdebase_dep kontact)
	$(add_kdebase_dep korganizer)
	$(add_kdebase_dep ktimetracker)
	nls? (
		$(add_kdebase_dep kde-l10n)
		$(add_kdebase_dep kdepim-l10n)
	)
"
