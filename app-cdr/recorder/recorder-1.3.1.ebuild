# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Recorder is a graphical (pygtk) frontend of cdrecord, mkisofs and growisofs"
HOMEPAGE="http://code.google.com/p/recorder/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND="sys-devel/gettext"
RDEPEND="dev-python/pygtk
	virtual/cdrtools
	app-cdr/dvd+rw-tools"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG || die "dodoc failed"
}
