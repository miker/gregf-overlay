# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit python eutils autotools versionator

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="avahi crypt dbus gnome idle libnotify nls spell srv trayicon X xhtml"

DEPEND=">=dev-lang/python-2.5
	dev-python/pygtk
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

RDEPEND=">=dev-lang/python-2.5[sqlite,xml]
	dev-python/pygtk
	dev-python/pyopenssl
	dev-python/sexy-python
	gnome? (
		dev-python/libgnome-python
		dev-python/gnome-keyring-python	
		trayicon? ( dev-python/egg-python ) )
	dbus? (
		dev-python/dbus-python
		dev-libs/dbus-glib
		libnotify? ( dev-python/notify-python )
		avahi? ( net-dns/avahi[dbus,gtk,python] ) )
	xhtml? ( dev-python/docutils )
	srv? ( || (
			dev-python/libasyncns-python
			net-dns/bind-tools ) )
	idle? ( x11-libs/libXScrnSaver )
	spell? ( app-text/gtkspell )
	crypt? (
		app-crypt/gnupg
		dev-python/pycrypto )"

pkg_setup() {
	if ! use dbus; then
		if use libnotify; then
			eerror "The dbus USE flag is required for libnotify support"
			die "USE=\"dbus\" needed for libnotify support"
		fi
		if use avahi; then
			eerror "The dbus USE flag is required for avahi support"
			die "USE=\"dbus\" needed for avahi support"
		fi
	fi
}

src_prepare() {
	# install pyfiles in /usr/lib/python2.x/site-packages/gajim
	# upstream: http://trac.gajim.org/ticket/5460
	epatch "${FILESDIR}/0.13_autotools--enable-site-packages_option.patch"
	eautoreconf
}

src_configure() {
	local myconf

	if ! use gnome; then
		myconf="${myconf} $(use_enable trayicon)"
	fi

	econf \
		$(use_enable nls) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--libdir="$(python_get_sitedir)" \
		--enable-site-packages \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	( 
	  cd "${D}/usr/share/doc/${PF}/"
	  rm README.html COPYING
	)
	dohtml README.html
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}/
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/${PN}/
}
