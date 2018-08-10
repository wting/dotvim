#!/bin/bash
# Ubuntu requirements: ncurses-dev python-dev
# Cygwin requirements: libncurses-devel python-dev

set -o errexit -o nounset -o pipefail

email="io@williamting.com"
tmp=$HOME/.vim/tmp
src="${tmp}/src"
dst=$HOME/bin/vim-8.0
python35_config=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu
python27_config=/usr/lib/python2.7/config-x86_64-linux-gnu
python26_config=/usr/lib/python2.6/config
python_config=

if [ -d "${python35_config}" ]; then
    python_config=${python35_config}
elif [ -d "${python27_config}" ]; then
    python_config=${python27_config}
elif [ -d "${python26_config}" ]; then
    python_config=${python26_config}
else
    echo "Could not find Python config directory."
    exit 1
fi

mkdir -vp ${tmp}
mkdir -vp ${dst}

if [[ -d "${src}" ]]; then
    cd ${src}
    git fetch origin --prune && git reset --hard origin/master
else
    git clone https://github.com/vim/vim.git ${src}
    cd ${src}
fi

./configure \
    --with-features=huge \
    --enable-gui=no \
    --enable-multibyte \
    --enable-cscope \
    --enable-pythoninterp \
    --with-python-config-dir=${python_config} \
    --prefix="${dst}" \
    --with-compiledby=${email}

make -j$(nproc) && make install

chmod +x ${dst}/bin/vim
ln -sfv ${dst}/bin/vim     ${HOME}/bin
ln -sfv ${dst}/bin/vimdiff ${HOME}/bin

echo
${dst}/bin/vim --version | head | grep --color "7.."
${dst}/bin/vim --version | head | grep --color "1-.*"
${dst}/bin/vim --version | grep -E --color "[-+]python[0-9]?"
echo -e "\ninstalled to: ${dst}\n"
