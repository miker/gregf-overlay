# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Database Frontend for GNOME"
HOMEPAGE="http://cf.andialbrecht.de/"
SRC_URI="http://crunchyfrog.googlecode.com/files/crunchyfrog-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql sqlite3 ldap postgres mssql"
RDEPEND="${DEPEND}
	dev-python/libbonobo-python
	dev-python/libgnomecanvas-python
	dev-python/kiwi
	dev-python/configobj
	dev-python/gnome-keyring-python
	dev-python/gnome-python-desktop-base
	dev-python/gnome-python-base
	dev-python/gtkmozembed-python
	dev-python/gnome-python-extras-base
	dev-python/sexy-python
	dev-python/dbus-python
	dev-python/setuptools
	dev-python/pygtksourceview
	>=dev-python/pygtk-2.12
	dev-python/lxml
	mysql? ( dev-db/mysql )
	sqlite3? ( dev-python/pysqlite )
	ldap? ( dev-python/python-ldap )
	postgres? ( >=dev-python/psycopg-2 )
	mssql? ( dev-python/pymssql )"

src_install() {
	dodoc AUTHORS COPYING INSTALL README TODO 
}
