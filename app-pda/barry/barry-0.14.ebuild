# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base

DESCRIPTION="Barry is an Open Source Linux application that will allow
synchronization, backup, restore, program management, and charging for BlackBerry devices"
HOMEPAGE="http://www.netdirect.ca/software/packages/barry/"
SRC_URI="mirror://sourceforge/barry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost doc gui opensync"

DEPEND=">=dev-libs/libusb-0.1
	dev-libs/openssl
	dev-util/pkgconfig
	boost? 	( >=dev-libs/boost-1.33  )
	doc?	( >=app-doc/doxygen-1.4.5 )
	gui? 	( >=dev-cpp/gtkmm-2.4
                >=dev-cpp/libglademm-2.4
                >=dev-cpp/glibmm-2.4
                =dev-libs/libtar-1.2.11-r1
		sys-libs/zlib )
        opensync? ( =app-pda/libopensync-0.22* )"
# Actually doxygen-1.4.5 is the only one tested by upstream, 
# but it's masked and they assume later versions work.

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" "${FILESDIR}/${P}-tarfile-int.patch")

src_compile(){
	econf \
		$(use_with boost boost =/usr/include) \
		$(use_enable gui) \
		$(use_with gui libtar =/usr/lib) \
		$(use_with gui libz =/usr/lib) \
		$(use_enable opensync opensync-plugin) \
		|| die "Error: econf failed!"
	emake || die "Error: emake failed!"
	
	if use doc ; then
		cd "${S}/src"
		doxygen
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	if use doc; then
		dodoc AUTHORS COPYING NEWS README
		dohtml doc/doxygen/html/*
	fi

	#  udev rules
	insinto /etc/udev/rules.d
	newins udev/10-blackberry.rules 10-blackberry.rules

	#  blacklist for BERRY_CHARGE kernel module
	insinto /etc/modprobe.d
	newins modprobe/blacklist-berry_charge blacklist-berry_charge

	#if use gui ; then
		# Add an entry into K Menu or gnome's menu if available.
	#fi
}

pkg_postinst() {
	elog
	elog "Users must be in the 'plugdev' group to access the Barry toolset."
	elog
	elog "Type 'btool' to launch the command-line Barry interface."
	use gui && elog "Type 'barrybackup' to launch the GUI backup/restore tool."
	ewarn
	ewarn "Barry and the in-kernel module 'BERRY_CHARGE' are incompatible."
	ewarn
	ewarn "Kernel-based USB suspending can discharge your blackberry."
	ewarn "Use at least kernel 2.6.22 and/or disable USB_SUSPEND."
	ewarn
}
