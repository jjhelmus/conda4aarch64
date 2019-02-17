#! /usr/bin/env python

import argparse
import bz2
import json
import os.path
import urllib.request

URL_TEMPLATE = ('https://conda.anaconda.org/{channel}/label/main/'
                '{subdir}/repodata.json.bz2')


def repodata_filename(channel, subdir):
    fname = f'{channel}_{subdir}_repodata.json.bz2'
    return os.path.join('cache', fname)


def get_repodata(channel, subdir):
    filename = repodata_filename(channel, subdir)
    url = URL_TEMPLATE.format(channel=channel, subdir=subdir)
    print("Saving:", filename)
    urllib.request.urlretrieve(url, filename=filename)
    return


def parse_repodata(channel, subdir):
    filename = repodata_filename(channel, subdir)
    with bz2.BZ2File(filename, 'r') as bfile:
        repodata = json.loads(bfile.read())
    packages = repodata['packages']
    names = set(pkg['name'] for pkg in packages.values())
    return names


def parse_arguments():
    parser = argparse.ArgumentParser(
        description="List packages not yet migrated to conda-forge")
    parser.add_argument(
        '--use_cache', action='store_true', help='used cached repodata')
    return parser.parse_args()


def main():
    args = parse_arguments()
    if not args.use_cache:
        get_repodata('c4aarch64', 'linux-aarch64')
        get_repodata('c4aarch64', 'noarch')
        get_repodata('conda-forge', 'linux-aarch64')
        get_repodata('conda-forge', 'noarch')
    c4_linux = parse_repodata('c4aarch64', 'linux-aarch64')
    c4_noarch = parse_repodata('c4aarch64', 'noarch')
    cf_linux = parse_repodata('conda-forge', 'linux-aarch64')
    cf_noarch = parse_repodata('conda-forge', 'noarch')
    c4_all = c4_linux | c4_noarch
    cf_all = cf_linux | cf_noarch
    missing = c4_all - cf_all
    print("Packages in c4aarch but not conda-forge")
    print("---------------------------------------")
    for name in sorted(missing):
        print(name)


if __name__ == "__main__":
    main()
