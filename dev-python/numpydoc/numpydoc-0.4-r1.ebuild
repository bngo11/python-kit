# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Sphinx extension to support docstrings in Numpy format"
HOMEPAGE="https://pypi.python.org/pypi/numpydoc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_prepare_all() {
	chmod -R a+r *.egg-info || die
	distutils-r1_python_prepare_all
}

python_test() {
	# Tests are written only for py2m pypy
	if ! python_is_python3; then
		nosetests || die "Testing failed with ${EPYTHON}"
	fi
}