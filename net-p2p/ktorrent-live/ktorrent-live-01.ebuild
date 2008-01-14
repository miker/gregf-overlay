inherit kde subversion eutils flag-o-matic

DESCRIPTION="A BitTorrent program for KDE (SVN version)"
HOMEPAGE="http://www.ktorrent.org/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/extragear/network/ktorrent"
ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/svn-src/"
LICENSE="GPL-2"
LANGS="br es it"
LANGS_DOC="es it"
USE_KEG_PACKAGING=1

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="!net-p2p/ktorrent
        dev-libs/gmp"

need-kde 3.4

src_unpack() {
        ESVN_UPDATE_CMD="svn update -N"
        ESVN_FETCH_CMD="svn checkout -N"
        ESVN_REPO_URI=`dirname ${ESVN_REPO_URI}`
        subversion_src_unpack

        S=${WORKDIR}/${P}/admin
        ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/branches/KDE/3.5/kde-common/admin"
        subversion_src_unpack

        ESVN_UPDATE_CMD="svn up"
        ESVN_FETCH_CMD="svn checkout"
        S=${WORKDIR}/${P}/ktorrent
        ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/extragear/network/ktorrent"
        subversion_src_unpack

        S=${WORKDIR}/${P}
        cd ${S}
        make -f Makefile.cvs
}

src_compile() {
        export WANT_AUTOCONF=2.5
        export WANT_AUTOMAKE=1.6

        local myconf="--enable-knetwork"

        kde_src_compile
}

src_install() {
        kde_src_install
}
