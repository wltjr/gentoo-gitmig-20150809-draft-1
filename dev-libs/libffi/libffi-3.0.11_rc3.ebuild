# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.0.11_rc3.ebuild,v 1.1 2012/04/06 14:56:42 ssuominen Exp $

EAPI=4

MY_P=${P/_/-}

inherit eutils libtool multilib toolchain-funcs

DESCRIPTION="a portable, high level programming interface to various calling conventions."
HOMEPAGE="http://sourceware.org/libffi/"
SRC_URI="ftp://sourceware.org/pub/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="debug static-libs test"

RDEPEND=""
DEPEND="test? ( dev-util/dejagnu )"

S=${WORKDIR}/${MY_P}

DOCS="ChangeLog* README"

pkg_setup() {
	# Check for orphaned libffi, see http://bugs.gentoo.org/354903 for example
	if ! has_version ${CATEGORY}/${PN}; then
		local base="${T}"/conftest
		echo 'int main() { }' > "${base}".c
		$(tc-getCC) -o "${base}" "${base}".c -lffi >&/dev/null
		if [ $? -eq = 0 ]; then
			eerror "The linker reported linking against -lffi to be working while it shouldn't have."
			eerror "This is wrong and you should find and delete the old copy of libffi before continuing."
			die "The system is in inconsistent state with unknown libffi installed." 
		fi
	fi
}

src_prepare() {
	elibtoolize
}

src_configure() {
	use userland_BSD && export HOST="${CHOST}"
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug)
}

src_install() {
	default
	rm -f "${ED}"/usr/lib*/lib*.la
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/${PN}$(get_libname 5)
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/${PN}$(get_libname 5)
}
