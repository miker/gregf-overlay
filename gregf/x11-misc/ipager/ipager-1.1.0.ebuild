# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="IPager is a pager for fluxbox and other window managers."
HOMEPAGE="http://www.useperl.ru/ipager/"
SRC_URI="http://www.useperl.ru/ipager/src/ipager-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="themes xinerama"
RDEPEND="x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext
	x11-proto/xextproto"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.96.1
	media-libs/freetype
	xinerama? ( x11-libs/libXinerama )"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ipager-${PV}-scons.patch || die "epatch for SConstruct failed"
}
src_compile() {
	if use xinerama; then
		myconf="${myconf} xinerama=yes"
	fi
	scons --cache-disable \
	${MAKEOPTS} ${myconf} CFLAGS="${CFLAGS}" || die "scons failed"
}
src_install() {
	scons --cache-disable DESTDIR=${D} PREFIX=/usr install \
	|| die "scons install failed"
	dodoc ChangeLog LICENSE README ToDo
	if use themes; then
		dodir /usr/share/ipager/themes
		insinto /usr/share/ipager/themes
		doins themes/*.conf || die "Could not install themes"
	fi
}

pkg_postinst() {
	einfo "If you had the themes used flag enabled some IPager themes"
	einfo "have been placed into /usr/share/ipager/themes/. Copying"
	einfo "theme to ~/.ipager/ipager.conf will allow you to use one."
}
