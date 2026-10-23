#!/usr/bin/env python3

import re


async def generate(hub, **pkginfo):
	versions = [ "2.7.18" ]
	minor = 10000
	async for tag in hub.pkgtools.github.iter_all_tags(hub, "python", "cpython"):
		v = re.match(r"v((\d+).(\d+).\d+\b)(?!-)", tag["name"])
		if v is None:
			continue

		if int(v[3]) >= int(minor):
			continue

		major, minor = v[2], v[3]
		if f"{major}.{minor}" not in ["3.12", "3.14"]:
			continue

		versions.append(v[1])

	revision = {
		"2.7.18" : "1",
	}

	for version in versions:
		shortver = version.split(".")[0:2]
		patch_url = f"https://distfiles.gentoo.org/pub/proj/python/patchsets/{'.'.join(shortver)}/python-gentoo-patches-{version}.tar.xz"
		python_url = f"https://www.python.org/ftp/python/{version}/Python-{version}.tar.xz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			revision=revision,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=python_url),
					hub.pkgtools.ebuild.Artifact(url=patch_url)],
			template=f'{pkginfo["name"]}{"_".join(shortver)}.tmpl',
		)
		ebuild.push()


# vim: ts=4 sw=4 noet
