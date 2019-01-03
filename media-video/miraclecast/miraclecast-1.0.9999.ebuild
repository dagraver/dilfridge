# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Wifi-Display/Miracast Implementation"
HOMEPAGE="https://github.com/albfan/miraclecast"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/akhuettel/miraclecast.git"
	EGIT_BRANCH="openrc-v1.0"
else
	SRC_URI="https://github.com/albfan/miraclecast/archive/v${PV}.tar.gz -> ${P}.tgz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="systemd test"

COMMONDEPEND="
	>=dev-libs/glib-2.38
	systemd? (
		>=sys-apps/systemd-221
	)
	!systemd? (
		sys-auth/elogind
		virtual/udev
	)
"
RDEPEND="${COMMONDEPEND}
	media-libs/gstreamer:1.0
"
DEPEND="${COMMONDEPEND}
	test? ( >=dev-libs/check-0.9.11 )
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_SYSTEMD=$(usex systemd)
	)

	cmake-utils_src_configure
}
