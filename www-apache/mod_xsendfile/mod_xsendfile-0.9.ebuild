# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_gnutls/mod_gnutls-0.5.2.ebuild,v 1.1 2008/09/16 15:45:35 trapni Exp $

inherit apache-module ssl-cert

DESCRIPTION="Apache2 module that processes X-SENDFILE headers registered by the original output handler"
HOMEPAGE="http://tn123.ath.cx/mod_xsendfile/"
SRC_URI="http://tn123.ath.cx/mod_xsendfile/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="50_${PN}"
#APACHE2_MOD_DEFINE="XSENDFILE"

DOCFILES="Readme.html"

need_apache2

src_compile() {
	apxs -ca mod_xsendfile.c
}
