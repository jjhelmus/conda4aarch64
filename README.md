## Introduction

This repository contains conda recipes, Docker images and tools for building a
set of [conda](https://conda.io/en/latest/) packages for the `linux-aarch64` 
platform. The result of this work is a 
[miniconda-like installer](https://github.com/jjhelmus/conda4aarch64/releases/download/1.0.0/c4aarch64_installer-1.0.0-Linux-aarch64.sh)
as well as conda packages in the [c4aarch64](https://anaconda.org/c4aarch64)
 channel. These artifacts are being used as a starting point for the
conda-forge community to build a more complete set of packages for this
 platform.

All packages were build inside a CentOS 7 Docker container and should support
Linux distributions which have a glibc version of 2.17 or newer. These 
packages should work on all major distribution which support 
ARMv8/aarch64 including Debian Jessie, Ubuntu 16.04, and Fedora 28.  

## Key package versions


| package | version |
| --- | --- |
| glibc | 2.17 |
| gcc | 7.3.0 |
| binutils | 2.29.1 |
| OpenSSL | 1.0.2p |
| Python | 3.7.2 |
| pip | 10.0.1 |
| conda | 4.5.12 |
| conda-build | 3.17.6 |
| constructor | 2.2.0 |
| anaconda-client | 1.6.14 |

Newer versions of binutils require 
[glibc 2.26 or newer on aarch64](https://github.com/crosstool-ng/crosstool-ng/commit/36bb675a71cc66a2abd69bc82d613f2153d3791f), 
therefore binutils 2.29.1 was used for compatibility with glibc 2.17.

The order in which recipes were built can be found in the 
[build_order.md](https://github.com/jjhelmus/conda4aarch64/blob/master/build_order.md) document.

## What's Next?

The conda-forge community has begun to build packages for the `linux-aarch64`
platform as part of the ARM/PowerPC migration.  This build out can be tracked 
on the [conda-forge status page](https://conda-forge.org/status/).  
Any help porting the recipes in this repository to conda-forge would be most appreciated.
A discussions around conda-forge's support of aarch64 as well as other ARM
 platforms can be found in 
[this GitHub issue.](https://github.com/conda-forge/conda-forge.github.io/issues/269)


## Related work

Based upon this and some earlier work, Mark Harfouche (@hmaarrkfk), started 
[Archiconda](https://github.com/Archiconda/build-tools) which uses 
[Shippable](https://app.shippable.com/subs/github/Archiconda/dashboard) 
to build `linux-aarch64` packages.

 
[Berryconda](https://github.com/jjhelmus/berryconda) is a conda based Python 
distribution for the Raspberry Pi single board computers. 
Two flavors of the distribution support the `armv7l` and `armv6l` Raspberry Pis.
