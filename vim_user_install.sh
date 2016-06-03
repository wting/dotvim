#!/bin/bash
# Ubuntu requirements: ncurses-dev python-dev
# Cygwin requirements: libncurses-devel python-dev

# set -o errexit -o nounset -o pipefail

email="io@williamting.com"
tmp=$HOME/.vim/tmp
src="${tmp}/src"
dst=$HOME/bin/vim-7.4
python27_config=/usr/lib/python2.7/config
python26_config=/usr/lib/python2.6/config
python_config=

if [ -d "${python27_config}" ]; then
    python_config=${python27_config}
elif [ -d "${python26_config}" ]; then
    python_config=${python26_config}
else
    echo "Could not find Python config directory."
    exit 1
fi

[[ -d "${tmp}" ]] || mkdir -vp ${tmp}
[[ -d "${tmp}/vim_source" ]] && rm -fr "${tmp}/vim_source"

if [[ -d "${src}" ]]; then
    cd ${src}
    git fetch origin --prune && git reset --hard origin/master || exit 1
else
    git clone https://github.com/vim/vim.git ${src} || exit 1
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
    --with-compiledby=$email || exit 1

[[ -d "${dst}" ]] || mkdir -vp ${dst}

make -j$(nproc) && make install || exit 1

chmod +x ${dst}
ln -sfv ${dst}/bin/vim     $HOME/bin
ln -sfv ${dst}/bin/vimdiff $HOME/bin

echo
${dst}/bin/vim --version | head | grep --color "7.."
${dst}/bin/vim --version | head | grep --color "1-.*"
${dst}/bin/vim --version | grep -E --color "[-+]python[0-9]?"
echo -e "\ninstalled to: ${dst}\n"
