# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font rpm

DESCRIPTION="Fonts to replace commonly used Microsoft Windows Fonts"
HOMEPAGE="http://www.redhat.com/promo/fonts/"
SRC_URI="http://www.redhat.com/f/fonts/${P}-4.el5.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

DOCS="License.txt"

src_install() {
	font_src_install

	# from http://uwstopia.nl/blog/2007/05/free-your-fonts
	insinto /etc/fonts/conf.avail
	newins ${FILESDIR}/fonts-conf-liberation-snippet.txt 60-liberation.conf \
		|| die "newins failed"
}

pkg_postinst() {
	einfo "To substitute Liberation fonts for Microsoft equivalents, use:"
	einfo "    ln -s ../conf.avail/60-liberation.conf /etc/fonts/conf.d/"
}
