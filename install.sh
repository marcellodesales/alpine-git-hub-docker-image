#! /bin/sh

set -ex

apk add --update --no-cache bash wget openssh libc6-compat

wget -O hub.tgz  --progress=dot:mega https://github.com/github/hub/releases/download/v2.3.0-pre10/hub-linux-amd64-2.3.0-pre10.tgz
mkdir /hub
tar -xvf hub.tgz -C /hub --strip-components 1
alias git=hub
bash /hub/install
hub --version
#=========== Clenaup ===========
rm -v hub.tgz
rm -frv /hub
apk del bash wget
