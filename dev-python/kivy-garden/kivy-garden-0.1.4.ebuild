# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Kivys Garden tool to manage flowers"
HOMEPAGE="http://kivy-garden.github.io/"
SRC_URI="https://pypi.io/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/garden-${PV}"

PATCHES=( "${FILESDIR}/remove_bat.patch" )
