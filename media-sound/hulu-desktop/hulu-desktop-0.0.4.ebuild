# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm

DESCRIPTION="Hulu desktop"
HOMEPAGE="http://www.hulu.com/labs/hulu-desktop-linux"
SRC_URI="amd64? ( http://download.hulu.com/huludesktop.x86_64.rpm )
		x86? ( http://download.hulu.com/huludesktop.i386.rpm )"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lirc"

DEPEND="www-plugins/adobe-flash
		x11-libs/gtk+:2
		dev-libs/glib
		lirc? ( app-misc/lirc )"
RDEPEND=""

src_unpack() {
	rpm_src_unpack
	cd "${S}"
}

src_install() {
	insinto /etc/huludesktop
	doins -r etc/huludesktop/hd_keymap.ini || die "Failed to install
	/etc/huludesktop/hd_keymap.ini"

	exeinto /usr/bin
	doexe usr/bin/huludesktop || die "Failed to install /usr/bin/huludesktop"

	insinto /usr/share
	domenu usr/share/applications/huludesktop.desktop
	doicon usr/share/pixmaps/huludesktop.png
	dodoc usr/share/doc/huludesktop/EULA \
		usr/share/doc/huludesktop/LICENSE \
		usr/share/doc/huludesktop/README
}

pkg_postinst() {
	elog "The file ~/.huludesktop should be created for you if you start Hulu Desktop"
	elog "but the path to the flash plugin is not set by default."
	elog
	elog "You need to add the following to ~/.huludesktop:"
	elog "[flash]"
	elog "flash_location = /usr/lib/nsbrowser/plugins/libflashplayer.so"
}
