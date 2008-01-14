# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mono

DESCRIPTION="Incollector is an application to collect various kind of information."
HOMEPAGE="http://www.incollector.devnull.pl"
SRC_URI="http://www.incollector.devnull.pl/download/sources/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RESTRICT="nomirror"

DEPEND=">=dev-dotnet/gtk-sharp-2.8
        >=dev-dotnet/glade-sharp-2.6
	    dev-lang/mono"
RDEPEND="${DEPEND}"

src_install() {
	dodoc INSTALL COPYING README AUTHORS
	emake DESTDIR="${D}" install || die "emake install failed"
}
