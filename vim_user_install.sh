#!/bin/bash
# Ubuntu requirements: mercurial ncurses-dev python-dev
email="io@williamting.com"
tmp=$HOME/.vim/tmp
src="$tmp/vim_source"
dst=$HOME/bin/vim7.4
python27_config=/usr/lib/python2.7/config
python26_config=/usr/lib/python2.6/config
python_config=

if [ -d "$python27_config" ]; then
    python_config=$python27_config
elif [ -d "$python26_config" ]; then
    python_config=$python26_config
else
    echo "Could not find Python config directory."
    exit 1
fi

[ -d "$tmp" ] || mkdir -vp $tmp

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
    --with-python-config-dir=$python_config \
    --prefix="$dst" \
    --with-compiledby=$email || exit 1

[ -d "$dst" ] || mkdir -vp $dst

make -j$(nproc) && make install || exit 1

ln -sfv $dst/bin/vim     $HOME/bin
ln -sfv $dst/bin/vimdiff $HOME/bin

echo
$dst/bin/vim --version | head | grep --color "VIM - Vi IMproved 7.4"
$dst/bin/vim --version | head | grep --color "Included patches"
$dst/bin/vim --version | head | grep --color "Compiled by $email"
$dst/bin/vim --version | grep -E --color "[-+]python"
echo -e "\ninstalled to: $dst\n"
