# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils multilib

MY_P="Miro-${PV}"
DESCRIPTION="A free and open internet TV platform."
HOMEPAGE="http://www.getdemocracy.com/"
SRC_URI="ftp://ftp.osuosl.org/pub/pculture.org/miro/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND="dev-python/pyrex
		>=virtual/python-2.5
		media-libs/xine-lib
		media-libs/libfame
		dev-libs/boost
		>=dev-python/pygtk-2.0
		dev-python/pysqlite
		dev-python/gnome-python-extras
		www-client/mozilla-firefox
		x11-libs/libX11
		dev-python/gst-python
		x11-apps/xset
		=dev-python/dbus-python-0.71"
		# dbus-python versions >0.80 changed the api so democracyplayer does
		# not work with them, therefore depending on the 0.71 version in portage
		# see https://develop.participatoryculture.org/democracy/ticket/3067

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="README"

S="${WORKDIR}/${MY_P}/platform/gtk-x11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/getlogin.patch
}
