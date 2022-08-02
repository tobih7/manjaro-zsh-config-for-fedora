#!/bin/bash

# manjaro-zsh-config installer for Fedora

# verify if the user is root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root!"
    exit 1
fi

set -e

# work in temporary directory
tmpdir=$(mktemp -d)
mkdir $tmpdir
pushd $tmpdir

# install dependencies
dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/Fedora_Rawhide/shells:zsh-users:zsh-completions.repo

dnf install zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions --assumeyes

mkdir -p /usr/share/zsh/plugins
git clone https://github.com/zsh-users/zsh-history-substring-search /usr/share/zsh/plugins/zsh-history-substring-search
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/zsh-theme-powerlevel10k

# some symlinks because install location is different on Fedora
ln -s /usr/share/zsh-autosuggestions /usr/share/zsh/plugins/zsh-autosuggestions
ln -s /usr/share/zsh-syntax-highlighting /usr/share/zsh/plugins/zsh-syntax-highlighting

# install actual "package"
curl https://gitlab.manjaro.org/packages/community/manjaro-zsh-config/-/raw/master/PKGBUILD -o PKGBUILD
. PKGBUILD

git clone https://github.com/Chrysostomus/manjaro-zsh-config
cd manjaro-zsh-config

package

# clean up
popd
rm -rf $tmpdir
