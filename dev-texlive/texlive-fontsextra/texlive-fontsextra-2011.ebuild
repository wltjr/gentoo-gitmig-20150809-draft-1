# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-fontsextra/texlive-fontsextra-2011.ebuild,v 1.10 2012/05/09 17:14:58 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="Asana-Math adforn adfsymbols allrunes antiqua antt ar archaic arev ascii astro augie auncial-new aurical b1encoding barcodes baskervald bbding bbm bbm-macros bbold bbold-type1 belleek bera berenisadf blacklettert1 boisik bookhands boondox braille brushscr calligra cantarell carolmin-ps ccicons cfr-lm cherokee cm-lgc cm-unicode cmbright cmll cmpica cmtiup comfortaa concmath-fonts courier-scaled cryst cyklop dancers dice dictsym dingbat doublestroke dozenal droid duerer duerer-latex ean ecc eco eiad eiad-ltx electrum elvish epigrafica epsdice esstix esvect eulervm euxm fdsymbol feyn fge foekfont fonetika fourier fouriernc frcursive genealogy gentium gfsartemisia gfsbodoni gfscomplutum gfsdidot gfsneohellenic gfssolomos gillcm gnu-freefont gothic greenpoint grotesq hands hfbright hfoldsty ifsym inconsolata initials iwona jablantile jamtimes junicode kixfont knuthotherfonts kpfonts kurier lato lfb libertine libris linearA lxfonts ly1 mathabx mathabx-type1 mathdesign mdputu mnsymbol nkarta ocherokee ocr-b ocr-b-outline ogham oinuit oldlatin oldstandard orkhun pacioli phaistos phonetic pigpen poltawski prodint psafm ptsans ptserif punk punknova recycle romande rsfso sauter sauterfonts semaphor skull staves starfont stix tapir tengwarscript tfrupee tpslifonts trajan txfontsb umtypewriter universa urwchancal venturisadf wsuipa xits yfonts collection-fontsextra
"
TEXLIVE_MODULE_DOC_CONTENTS="Asana-Math.doc adforn.doc adfsymbols.doc allrunes.doc antiqua.doc antt.doc ar.doc archaic.doc arev.doc ascii.doc astro.doc augie.doc auncial-new.doc aurical.doc b1encoding.doc barcodes.doc baskervald.doc bbding.doc bbm.doc bbm-macros.doc bbold.doc bbold-type1.doc belleek.doc bera.doc berenisadf.doc blacklettert1.doc boisik.doc bookhands.doc boondox.doc braille.doc brushscr.doc calligra.doc cantarell.doc carolmin-ps.doc ccicons.doc cfr-lm.doc cherokee.doc cm-lgc.doc cm-unicode.doc cmbright.doc cmll.doc cmpica.doc cmtiup.doc comfortaa.doc concmath-fonts.doc courier-scaled.doc cryst.doc cyklop.doc dice.doc dictsym.doc dingbat.doc doublestroke.doc dozenal.doc droid.doc duerer.doc duerer-latex.doc ean.doc ecc.doc eco.doc eiad.doc eiad-ltx.doc electrum.doc elvish.doc epigrafica.doc epsdice.doc esstix.doc esvect.doc eulervm.doc fdsymbol.doc feyn.doc fge.doc foekfont.doc fonetika.doc fourier.doc fouriernc.doc frcursive.doc genealogy.doc gentium.doc gfsartemisia.doc gfsbodoni.doc gfscomplutum.doc gfsdidot.doc gfsneohellenic.doc gfssolomos.doc gillcm.doc gnu-freefont.doc gothic.doc greenpoint.doc grotesq.doc hfbright.doc hfoldsty.doc ifsym.doc inconsolata.doc initials.doc iwona.doc jablantile.doc jamtimes.doc junicode.doc kixfont.doc kpfonts.doc kurier.doc lato.doc lfb.doc libertine.doc libris.doc linearA.doc lxfonts.doc ly1.doc mathabx.doc mathabx-type1.doc mathdesign.doc mdputu.doc mnsymbol.doc nkarta.doc ocherokee.doc ocr-b.doc ocr-b-outline.doc ogham.doc oinuit.doc oldlatin.doc oldstandard.doc orkhun.doc pacioli.doc phaistos.doc phonetic.doc pigpen.doc poltawski.doc prodint.doc ptsans.doc ptserif.doc punknova.doc recycle.doc romande.doc rsfso.doc sauterfonts.doc semaphor.doc staves.doc starfont.doc stix.doc tapir.doc tengwarscript.doc tfrupee.doc tpslifonts.doc trajan.doc txfontsb.doc universa.doc urwchancal.doc venturisadf.doc wsuipa.doc xits.doc yfonts.doc "
TEXLIVE_MODULE_SRC_CONTENTS="allrunes.source archaic.source arev.source ascii.source auncial-new.source b1encoding.source barcodes.source baskervald.source bbding.source bbm-macros.source bbold.source belleek.source berenisadf.source blacklettert1.source bookhands.source brushscr.source cantarell.source ccicons.source cfr-lm.source cmbright.source cmll.source comfortaa.source dingbat.source dozenal.source droid.source eco.source eiad-ltx.source electrum.source epsdice.source esvect.source eulervm.source fdsymbol.source feyn.source fge.source fourier.source frcursive.source gentium.source gnu-freefont.source hfbright.source hfoldsty.source inconsolata.source lato.source libris.source linearA.source mnsymbol.source nkarta.source ocr-b-outline.source oinuit.source oldstandard.source pacioli.source phaistos.source romande.source sauterfonts.source skull.source staves.source tengwarscript.source tfrupee.source trajan.source txfontsb.source universa.source venturisadf.source xits.source yfonts.source "
inherit  texlive-module
DESCRIPTION="TeXLive Extra fonts"

LICENSE="GPL-2 as-is BSD GPL-1 GPL-2 GPL-3 LPPL-1.3 OFL public-domain TeX "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!=dev-texlive/texlive-langpolish-2007*
"
RDEPEND="${DEPEND} "
