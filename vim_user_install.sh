#!/bin/bash
# Requires nurses-dev package on Ubuntu
src=$HOME/.vim/tmp/vim
dst=$HOME/bin/vim7.4

if [ -d "$src" ]; then
    cd $src
    hg pull
else
    hg clone https://vim.googlecode.com/hg/ $src
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
    --with-compiledby=io@williamting.com

[ -d "$dst" ] || mkdir -vp $dst

make -j$(nproc) && make install

echo $dst
ln -sfv $dst/bin/vim     $HOME/bin
ln -sfv $dst/bin/vimdiff $HOME/bin
