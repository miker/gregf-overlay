# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PV=_2_5_2
DESCRIPTION="TinyXml is a simple C++ XML parser that can be easily integrating into other programs"
HOMEPAGE="http://www.grinninglizard.com/tinyxml/index.html"
SRC_URI="mirror://sourceforge/${PN}/${PN}${MY_PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	# not all that needed but there it is anyway
	if ! use debug; then
		sed -i -e 's:DEBUG          \:= YES:DEBUG          \:= NO:' Makefile || die "sed failed"
	fi
}

src_compile() {
	if use debug; then
		emake	|| die "emake failed"
	else
		emake CXXFLAGS="${CXXFLAGS} -DTIXML_USE_STL"  || die "emake failed"
	fi
}

src_install () {
	exeinto /usr/bin
	doexe xmltest	|| die "install failed"
	dodoc {changes,readme}.txt
	dohtml docs/*
}

