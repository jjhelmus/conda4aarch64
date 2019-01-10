About psutil
============

Home: https://github.com/giampaolo/psutil

Package license: BSD 3-Clause

Feedstock license: BSD 3-Clause

Summary: A cross-platform process and system utilities module for Python

psutil (process and system utilities) is a cross-platform library for
retrieving information on running processes and system utilization (CPU,
memory, disks, network) in Python. It is useful mainly for system
monitoring, profiling and limiting process resources and management of
running processes.


Current build status
====================

[![Linux](https://img.shields.io/circleci/project/github/conda-forge/psutil-feedstock/master.svg?label=Linux)](https://circleci.com/gh/conda-forge/psutil-feedstock)
[![OSX](https://img.shields.io/travis/conda-forge/psutil-feedstock/master.svg?label=macOS)](https://travis-ci.org/conda-forge/psutil-feedstock)
[![Windows](https://img.shields.io/appveyor/ci/conda-forge/psutil-feedstock/master.svg?label=Windows)](https://ci.appveyor.com/project/conda-forge/psutil-feedstock/branch/master)

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-psutil-green.svg)](https://anaconda.org/conda-forge/psutil) | [![Conda Downloads](https://img.shields.io/conda/dn/conda-forge/psutil.svg)](https://anaconda.org/conda-forge/psutil) | [![Conda Version](https://img.shields.io/conda/vn/conda-forge/psutil.svg)](https://anaconda.org/conda-forge/psutil) | [![Conda Platforms](https://img.shields.io/conda/pn/conda-forge/psutil.svg)](https://anaconda.org/conda-forge/psutil) |

Installing psutil
=================

Installing `psutil` from the `conda-forge` channel can be achieved by adding `conda-forge` to your channels with:

```
conda config --add channels conda-forge
```

Once the `conda-forge` channel has been enabled, `psutil` can be installed with:

```
conda install psutil
```

It is possible to list all of the versions of `psutil` available on your platform with:

```
conda search psutil --channel conda-forge
```


About conda-forge
=================

conda-forge is a community-led conda channel of installable packages.
In order to provide high-quality builds, the process has been automated into the
conda-forge GitHub organization. The conda-forge organization contains one repository
for each of the installable packages. Such a repository is known as a *feedstock*.

A feedstock is made up of a conda recipe (the instructions on what and how to build
the package) and the necessary configurations for automatic building using freely
available continuous integration services. Thanks to the awesome service provided by
[CircleCI](https://circleci.com/), [AppVeyor](https://www.appveyor.com/)
and [TravisCI](https://travis-ci.org/) it is possible to build and upload installable
packages to the [conda-forge](https://anaconda.org/conda-forge)
[Anaconda-Cloud](https://anaconda.org/) channel for Linux, Windows and OSX respectively.

To manage the continuous integration and simplify feedstock maintenance
[conda-smithy](https://github.com/conda-forge/conda-smithy) has been developed.
Using the ``conda-forge.yml`` within this repository, it is possible to re-render all of
this feedstock's supporting files (e.g. the CI configuration files) with ``conda smithy rerender``.

For more information please check the [conda-forge documentation](https://conda-forge.org/docs/).

Terminology
===========

**feedstock** - the conda recipe (raw material), supporting scripts and CI configuration.

**conda-smithy** - the tool which helps orchestrate the feedstock.
                   Its primary use is in the construction of the CI ``.yml`` files
                   and simplify the management of *many* feedstocks.

**conda-forge** - the place where the feedstock and smithy live and work to
                  produce the finished article (built conda distributions)


Updating psutil-feedstock
=========================

If you would like to improve the psutil recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`conda-forge` channel, whereupon the built conda packages will be available for
everybody to install and use from the `conda-forge` channel.
Note that all branches in the conda-forge/psutil-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://conda.io/docs/user-guide/tasks/build-packages/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://conda.io/docs/user-guide/tasks/build-packages/define-metadata.html#build-number-and-string)
   back to 0.
