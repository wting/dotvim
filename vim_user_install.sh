#!/bin/bash
# Ubuntu requirements: python-dev python3-dev
# OSX requirements: python via homebrew

set -o errexit -o nounset -o pipefail

email="io@williamting.com"
tmp=$HOME/.vim/tmp
src="${tmp}/src"
dst=$HOME/bin/vim-compiled
# Find where python/config.c lives.
# Potential Linux paths followed by OSX paths.
declare -a potential_python2_config_paths=(
    "/usr/lib/python2.7/config-x86_64-linux-gnu"
    "/usr/lib/python2.7/config"
    "/usr/lib/python2.6/config"
)

python2_config=
for potential_config_path in "${potential_python2_config_paths[@]}"; do
    if [ -d "${potential_config_path}" ]; then
        echo "found python2 config_path=${potential_config_path}"
        python2_config=${potential_config_path}
        break
    fi
done

declare -a potential_python3_config_paths=(
    "/usr/lib/python3.10/config-3.10-x86_64-linux-gnu"
    "/usr/lib/python3.9/config-3.9-x86_64-linux-gnu"
    "/usr/lib/python3.8/config-3.8-x86_64-linux-gnu"
    "/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"
    "/usr/local/Cellar/python@3.10/3.10.6_2/Frameworks/Python.framework/Versions/3.10/lib/python3.10/config-3.10-darwin"
    "/opt/homebrew/Cellar/python@3.10/3.10.6_2/Frameworks/Python.framework/Versions/3.10/lib/python3.10/config-3.10-darwin"
)

python3_config=
for potential_config_path in "${potential_python3_config_paths[@]}"; do
    if [ -d "${potential_config_path}" ]; then
        echo "found python3 config_path=${potential_config_path}"
        python3_config=${potential_config_path}
        break
    fi
done

if [[ "${python2_config}" == "" && "${python3_config}" == "" ]]; then
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
    --enable-pythoninterp=yes \
    --with-python-config-dir=${python2_config} \
    --enable-python3interp=yes \
    --with-python3-config-dir=${python3_config} \
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
