# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.8.2.ebuild,v 1.1 2008/10/31 20:45:54 cardoe Exp $

inherit autotools eutils flag-o-matic git libtool

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
EGIT_REPO_URI="git://git.cairographics.org/git/cairo"


LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug directfb doc glitz opengl svg X xcb"

# Test causes a circular depend on gtk+... since gtk+ needs cairo but test needs gtk+ so we need to block it
RESTRICT="test"

RDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2.1.9
	sys-libs/zlib
	media-libs/libpng
	>=x11-libs/pixman-0.12.0
	directfb? ( >=dev-libs/DirectFB-0.9.24 )
	glitz? ( >=media-libs/glitz-0.5.1 )
	svg? ( dev-libs/libxml2 )
	dev-util/git
	X? ( 	>=x11-libs/libXrender-0.6
		x11-libs/libXext
		x11-libs/libX11
		virtual/xft )
	xcb? (	>=x11-libs/libxcb-0.92
		x11-libs/xcb-util )"
#	test? (
#	pdf test
#	x11-libs/pango
#	>=x11-libs/gtk+-2.0
#	>=app-text/poppler-bindings-0.9.2
#	ps test
#	virtual/ghostscript
#	svg test
#	>=x11-libs/gtk+-2.0
#	>=gnome-base/librsvg-2.15.0

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	doc? (	>=dev-util/gtk-doc-1.6
		~app-text/docbook-xml-dtd-4.2 )
	X? ( x11-proto/renderproto )
	xcb? ( x11-proto/xcb-proto )"

src_compile() {
	elibtoolize
	eautoreconf
	#gets rid of fbmmx.c inlining warnings
	append-flags -finline-limit=1200

	if use glitz && use opengl; then
		export glitz_LIBS=-lglitz-glx
	fi

	econf $(use_enable X xlib) $(use_enable doc gtk-doc) \
		$(use_enable directfb) $(use_enable xcb) \
		$(use_enable svg) $(use_enable glitz) $(use_enable X xlib-xrender) \
		$(use_enable debug test-surfaces) --enable-pdf  --enable-png \
		--enable-freetype --enable-ps \
		|| die "configure failed"

	emake || die "compile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
}
