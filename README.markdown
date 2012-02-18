
My personal .vimrc and collection of plugins and themes.

## Setup

### Requirements

The Command-T plugin requires Vim with Ruby support. Installing `gvim` or `vim-gnome` package will usually solve this problem. For more info, refer to the [plugin page](http://www.vim.org/scripts/script.php?script_id=3025).

### Automatic Method

via `curl`

`curl -L https://github.com/wting/dotvim/raw/master/install.sh | sh`

via `wget`

`wget --no-check-certificate https://github.com/wting/dotvim/raw/master/tools/install.sh -O - | sh`

### Manual Method

1. Clone the repository.

	git clone git://github.com/wting/dotvim.git ~/.vim

2. Create the new .vimrc file.

	ln -s ~/.vim/vimrc ~/.vimrc

Enjoy!
