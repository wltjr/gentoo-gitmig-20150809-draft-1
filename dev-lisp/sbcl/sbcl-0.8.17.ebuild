# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.17.ebuild,v 1.2 2004/12/13 12:25:30 swegener Exp $

inherit common-lisp-common eutils

BV_SBCL_AF=2004-10-22

BV_X86=0.8.1
BV_PPC=0.8.8
BV_SPARC=0.7.13
BV_MIPS=0.7.10
DESCRIPTION="Steel Bank Common Lisp (SBCL) is an implementation of ANSI Common Lisp."
HOMEPAGE="http://sbcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	mirror://sourceforge/sbcl/${P}-html.tar.bz2
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-ppc-linux-binary.tar.bz2 )
	sparc? ( mirror://sourceforge/sbcl/${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2 )
	mips? ( mirror://sourceforge/sbcl/${PN}-${BV_MIPS}-mips-linux-binary.tar.gz )
	ftp://common-lisp.net/pub/project/lambda-gtk/sbcl-af-${BV_SBCL_AF}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-*" # due to sb-unicode problems
IUSE="threads doc nosource nounicode ldb nosbcl-af"

DEPEND=">=dev-lisp/common-lisp-controller-3.91
	>=dev-lisp/cl-defsystem3-3.3i-r3
	>=dev-lisp/cl-asdf-1.84
	sys-apps/texinfo
	doc? ( virtual/tetex )"

PROVIDE="virtual/commonlisp"

src_unpack() {
	if use x86; then
		unpack ${PN}-${BV_X86}-x86-linux-binary.tar.bz2
		mv ${PN}-${BV_X86} x86-binary
	elif use ppc; then
		unpack ${PN}-${BV_PPC}-ppc-linux-binary.tar.bz2
		mv ${PN}-${BV_PPC}-ppc-linux ppc-binary
	elif use sparc; then
		unpack ${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2
		echo mv ${PN}-${BV_SPARC} sparc-binary || die
		mv ${PN}-${BV_SPARC} sparc-binary || die
	elif use mips; then
		unpack ${PN}-${BV_SPARC}-mips-linux-binary.tar.gz
		mv ${PN}-${BV_SPARC}-mips-linux mips-binary
	fi

	if use callbacks; then
		unpack sbcl-af-${BV_SBCL}.tar.gz
	fi

	unpack ${P}-source.tar.bz2
	epatch ${FILESDIR}/${PV}/sbcl-gentoo.patch
	epatch ${FILESDIR}/${PV}/sbcl-no-tests-gentoo.patch

	cp ${FILESDIR}/${PV}/customize-target-features.lisp-prefix \
		${S}/customize-target-features.lisp
	use x86 && use threads \
		&& echo '(enable :sb-threads)' \
		>>${S}/customize-target-features.lisp
	use ldb \
		&& echo '(enable :sb-ldb)' \
		>>${S}/customize-target-features.lisp
	echo '(enable :sb-futex)' >>${S}/customize-target-features.lisp
	echo '(disable :sb-test)' >>${S}/customize-target-features.lisp
	use nounicode \
		&& echo '(disable :sb-unicode)' \
		>>${S}/customize-target-features.lisp
	cat ${FILESDIR}/${PV}/customize-target-features.lisp-suffix \
		>>${S}/customize-target-features.lisp
	find ${S} -type f -name .cvsignore -exec rm -f '{}' \;
	find ${S} -type d -name CVS \) -exec rm -rf '{}' \;
	find ${S} -type f -name \*.c -exec chmod 644 '{}' \;
}

src_compile() {
	local bindir
	use x86 && bindir=../x86-binary
	use ppc && bindir=../ppc-binary
	use sparc && bindir=../sparc-binary
	use mips && bindir=../mips-binary
	PATH=${bindir}/src/runtime:${PATH} SBCL_HOME=${bindir}/output GNUMAKE=make \
		./make.sh 'sbcl
			--sysinit /dev/null
			--userinit /dev/null
			--no-debugger
			--core ${bindir}/output/sbcl.core' \
				|| die
	cd ${S}/doc/manual
	make info
	use doc && make ps pdf
}

src_install() {
	unset SBCL_HOME

	insinto /etc/
	doins ${FILESDIR}/${PV}/sbclrc	# Gentoo specific (from Debian)

	exeinto /usr/lib/common-lisp/bin
	doexe ${FILESDIR}/${PV}/sbcl.sh	# Gentoo specific (from Debian)

	dodir /usr/share/man
	INSTALL_ROOT=${D}/usr sh install.sh
	mv ${D}/usr/lib/sbcl/sbcl.core ${D}/usr/lib/sbcl/sbcl-dist.core

	insinto /usr/lib/sbcl
	doins ${FILESDIR}/${PV}/install-clc.lisp	# Gentoo specific (from Debian)

	doman doc/sbcl-asdf-install.1

	dodoc BUGS COPYING CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES README STYLE SUPPORT TLA TODO
	dodoc ${FILESDIR}/${PV}/README.Gentoo
	dohtml doc/html/*

	doinfo ${S}/doc/manual/*.info
	use doc && dodoc ${S}/doc/manual/*.{pdf,ps}

	keepdir /usr/lib/common-lisp/sbcl

	if ! use nosource; then
		# install the SBCL source
		find ${S}/src -type f -name \*.fasl |xargs rm -f
		mv ${S}/src ${D}/usr/lib/sbcl/
	fi

	impl-save-timestamp-hack sbcl || die
}

pkg_postinst() {
	standard-impl-postinst sbcl
}

pkg_postrm() {
	standard-impl-postrm sbcl /usr/bin/sbcl
}
