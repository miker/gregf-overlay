# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils multilib

DESCRIPTION="Database navigator and query tool for GNOME"
HOMEPAGE="http://cf.andialbrecht.de/"
SRC_URI="http://crunchyfrog.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="postgres mysql sqlite mssql ldap"

RDEPEND="
	>=dev-python/pygtk-2.12
	>=dev-python/lxml-0.9
	>=dev-python/kiwi-1.8
	>=dev-python/configobj-4.4.0
	>=dev-python/gnome-python-2.18
	dev-python/gtkmozembed-python
	dev-python/sexy-python
	dev-python/dbus-python
	dev-python/pygtksourceview
	dev-python/gnome-keyring-python
	postgres? ( >=dev-python/psycopg-2.0.2 )
	mysql? ( >=dev-python/mysql-python-1.2 )
	sqlite? ( || ( >=dev-lang/python-2.5
		>=dev-python/pysqlite-2.3 ) )
	ldap? ( >=dev-python/python-ldap-2.2 )
	mssql? ( dev-python/pymssql )"
DEPEND="${RDEPEND}"

src_compile() {
	export GTKMOZEMBED_PATH=/usr/$(get_libdir)/firefox
	sed -e "s:\(GTKMOZEMBED_PATH\)=:\1 ?= :" -i Makefile

	if built_with_use dev-python/gtkmozembed-python xulrunner; then
		GTKMOZEMBED_PATH=/usr/$(get_libdir)/xulrunner-1.9
	fi

	emake || die "make failed"

}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
}
