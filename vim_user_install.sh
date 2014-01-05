#!/bin/bash
# Ubuntu package requirements: mercurial, ncurses-dev, python2.7-dev
email="io@williamting.com"
src=$HOME/.vim/tmp/vim_source
dst=$HOME/bin/vim7.4

if [ -d "$src" ]; then
    cd $src
    hg pull && hg update || exit 1
else
    hg clone https://vim.googlecode.com/hg/ $src || exit 1
    cd $src
fi

./configure \
    --with-features=huge \
    --enable-gui=gtk2 \
    --enable-multibyte \
    --enable-cscope \
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib/python2.7/config \
    --prefix="$dst" \
    --with-compiledby=${email} || exit 1

[ -d "$dst" ] || mkdir -vp $dst

make -j$(nproc) && make install || exit 1

ln -sfv $dst/bin/vim     $HOME/bin
ln -sfv $dst/bin/vimdiff $HOME/bin

$dst/bin/vim --version | head | grep "VIM - Vi IMproved 7.4"
$dst/bin/vim --version | head | grep "Included patches"
$dst/bin/vim --version | head | grep "Compiled by ${email}"
$dst/bin/vim --version | grep "-python"
$dst/bin/vim --version | grep "+python"
