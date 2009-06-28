# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: uzbl-9999.ebuild by Karol Czeryna

EAPI=2

inherit git

EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"

DESCRIPTION="a keyboard controlled (modal vim-like bindings, or with modifierkeys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org"
SRC_URI=""

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dmenu zenity"

RDEPEND=">=net-libs/webkit-gtk-1.1.7
        >=net-libs/libsoup-2.26.2
        >=x11-libs/gtk+-2.14
        dmenu? (
        x11-misc/dmenu
        )
        zenity? (
        gnome-extra/zenity
        )"
DEPEND="${RDEPEND}
    >=dev-util/pkgconfig-0.19
    "

src_unpack() {
	git_src_unpack
	cd "${S}"
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS README
}
