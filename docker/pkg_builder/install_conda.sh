#!/bin/bash
set -euxo pipefail

fname="c4aarch64_installer-1.0.0-Linux-aarch64.sh"
curl -LO https://github.com/jjhelmus/conda4aarch64/releases/download/1.0.0/$fname
bash -x $fname -bfp /opt/conda

# set some default setting
/opt/conda/bin/conda config --set show_channel_urls True
/opt/conda/bin/conda config --set add_pip_as_python_dependency False
/opt/conda/bin/conda clean -ptiy
rm -rf $fname
