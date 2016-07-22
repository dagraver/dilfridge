# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KMNAME="kdepim"
KDE_HANDBOOK=optional
VIRTUALX_REQUIRED=test
inherit flag-o-matic kde4-meta

DESCRIPTION="Email component of Kontact (noakonadi branch)"
HOMEPAGE="https://launchpad.net/~pali/+archive/ubuntu/kdepim-noakonadi"
KEYWORDS="~amd64"
IUSE="debug"

EGIT_BRANCH=trim
EGIT_REPO_URI=http://github.com/akhuettel/kdepim-noakonadi.git

DEPEND="
	$(add_kdebase_dep kdelibs '' 4.13.1)
	$(add_kdeapps_dep kdepimlibs '' 4.13.1)
	$(add_kdeapps_dep libkdepim '' 4.4.11.1-r1)
	$(add_kdeapps_dep libkleo '' 4.4.2015)
	$(add_kdeapps_dep libkpgp '' 4.4.2015)
"
RDEPEND="${DEPEND}
	!>=kde-apps/kdepimlibs-4.14.11_pre20160211
"

KMEXTRACTONLY="
	korganizer/org.kde.Korganizer.Calendar.xml
	libkleo/
	libkpgp/
"
KMEXTRA="
	kmailcvt/
	ksendemail/
	libksieve/
	messagecore/
	messagelist/
	messageviewer/
	mimelib/
	plugins/kmail/
"
KMLOADLIBS="libkdepim"

src_configure() {
	mycmakeargs=(
		-DWITH_IndicateQt=OFF
	)

	kde4-meta_src_configure
}

src_compile() {
	kde4-meta_src_compile kmail_xml
	kde4-meta_src_compile
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-apps/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-apps/kdepim-kresources:${SLOT}"
		echo
	fi
	if ! has_version kde-apps/kleopatra:${SLOT}; then
		echo
		elog "For certificate management and the gnupg log viewer, please install kde-apps/kleopatra:${SLOT}"
		echo
	fi
}
