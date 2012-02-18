
My personal .vimrc and collection of plugins and themes.

## Setup

### Requirements

The Command-T plugin requires vim with Ruby support. Installing `gvim` or `vim-gnome` package will usually solve this problem. For more info, refer to the [plugin page](http://www.vim.org/scripts/script.php?script_id=3025).

### Automatic Method

via `curl`, backing up existing customizations:

`curl -L https://github.com/wting/dotvim/raw/master/install.sh | sh`

via `curl`, replacing existing customizations:

`curl -L https://github.com/wting/dotvim/raw/master/replace.sh | sh`

### Manual Method

1. Clone the repository.

	git clone git://github.com/wting/dotvim.git ~/.vim

2. Create the new .vimrc file.

	ln -s ~/.vim/.vimrc ~/.vimrc

## Plugins

- [Command-T](http://www.vim.org/scripts/script.php?script_id=3025): Activated by `shift t` in command mode, provides fast file open.
- [CSApprox](http://www.vim.org/scripts/script.php?script_id=2390): Brings gvim color schemes into terminal vim.
- [Indent Guides](http://www.vim.org/scripts/script.php?script_id=3361): Visually displays indentation levels.
- [Local vimrc](http://www.vim.org/scripts/script.php?script_id=441): Sources .lvimrc after .vimrc to allow for project / directory specific vim settings.
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540): Implements TextMate snippets feature, [quick intro](http://vimeo.com/3535418).
- [Syntastic](http://www.vim.org/scripts/script.php?script_id=2736): Syntax checking plugin.
- [vimwiki](http://www.vim.org/scripts/script.php?script_id=2226): Personalized wiki within vim.

## Themes

The selected color scheme is [zenburn](http://slinky.imukuppi.org/zenburnpage/), a low-contrast theme primarily for dark environments. Others are listed in `~/.vim/colors/`.

![zenburn color scheme](http://slinky.imukuppi.org/wpress/wp-content/uploads/2008/04/zenburn.png "zenburn")

Enjoy!
