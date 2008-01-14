# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

MY_P="27913-PolarCursorThemes"
DESCRIPTION="A smooth white cursor theme."
HOMEPAGE="http://kde-look.org/content/show.php?content=27913"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/$MY_P.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir /usr/share/cursors/xorg-x11/PolarCursorTheme/cursors/
	cp -R  ${WORKDIR}/PolarCursorTheme/cursors ${D}/usr/share/cursors/xorg-x11/PolarCursorTheme/ || die
	dodir /usr/share/cursors/xorg-x11/PolarCursorTheme-Blue/cursors/
	cp -R  ${WORKDIR}/PolarCursorTheme-Blue/cursors ${D}/usr/share/cursors/xorg-x11/PolarCursorTheme-Blue/ || die
	dodir /usr/share/cursors/xorg-x11/PolarCursorTheme-Green/cursors/
	cp -R  ${WORKDIR}/PolarCursorTheme-Green/cursors ${D}/usr/share/cursors/xorg-x11/PolarCursorTheme-Green/ || die
	#dodoc ${WORKDIR}/${MY_P:6}/COPYRIGHT~
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: Polar"
	einfo ""
	einfo "You can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	einfo ""
	einfo "Also, to globally use this set of mouse cursors edit the file:"
	einfo "   /usr/share/cursors/xorg-x11/default/index.theme"
	einfo "and change the line:"
	einfo "    Inherits=[current setting]"
	einfo "to"
	einfo "    Inherits=Polar"
	einfo ""
	einfo "Note this will be overruled by a user's ~/.Xdefaults file."
	einfo ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn ""
	ewarn "the Device section of your xorg.conf file:"
	ewarn "    Option  \"HWCursor\"  \"false\""
}
