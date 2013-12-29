#!/bin/bash
# Requires ncurses-dev package on Ubuntu
src=$HOME/.vim/tmp/vim_source
dst=$HOME/bin/vim7.4

if [ -d "$src" ]; then
    cd $src
    hg pull || exit 1
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
    --enable-python3interp \
    --prefix="$dst" \
    --with-compiledby=io@williamting.com || exit 1

[ -d "$dst" ] || mkdir -vp $dst

make -j$(nproc) && make install || exit 1

ln -sfv $dst/bin/vim     $HOME/bin
ln -sfv $dst/bin/vimdiff $HOME/bin

$dst/bin/vim --version | head