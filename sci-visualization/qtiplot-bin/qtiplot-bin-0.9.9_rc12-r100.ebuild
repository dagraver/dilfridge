# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Qt based clone of the Origin plotting package, commercial binary"
HOMEPAGE="http://www.qtiplot.com/"
SRC_URI="180814_qtiplot-0.9.9-rc12-32bit-static.tar.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch mirror splitdebug"
IUSE=""

QA_PREBUILT="*"

S=${WORKDIR}

RDEPEND="
	|| (
		(
			dev-db/sqlite:0[abi_x86_32(-)]
			=virtual/mysql-5.5*[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-db[-abi_x86_32(-)]
		)
	)
	|| (
		dev-libs/glib[abi_x86_32(-)]
		amd64? (
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
		)
	)
	|| (
		virtual/glu[abi_x86_32(-)]
		amd64? (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
		)
	)
	|| (
		(
			media-libs/fontconfig[abi_x86_32(-)]
			media-libs/freetype[abi_x86_32(-)]
			x11-libs/libICE[abi_x86_32(-)]
			x11-libs/libSM[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
			x11-libs/libXrender[abi_x86_32(-)]
			x11-libs/libX11[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)
	!sci-visualization/qtiplot
"

src_install() {
	dodir /opt
	cp -av "${S}"/qtiplot-* "${D}/opt/qtiplot" || die

	dosym ../qtiplot/qtiplot /opt/bin/qtiplot
}
