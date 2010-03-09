# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-0.11.1.ebuild,v 1.14 2010/01/12 10:32:08 grobian Exp $

EAPI="2"

inherit distutils eutils

DESCRIPTION="The mygpoclient library allows developers to utilize a Pythonic interface to the my.gpodder.org web services."
HOMEPAGE="http://thpinfo.com/2010/mygpoclient/"
SRC_URI="http://thpinfo.com/2010/mygpoclient/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	    dev-python/simplejson"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install --install-data "${EPREFIX}/usr/share"
}
