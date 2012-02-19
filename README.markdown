
My personal .vimrc and collection of plugins and themes.

## Setup

### Automatic Method

Backing up existing customizations:

`curl -L https://github.com/wting/dotvim/raw/master/install.sh | sh`

Replacing existing customizations:

`curl -L https://github.com/wting/dotvim/raw/master/replace.sh | sh`

### Manual Method

1. Clone the repository.

	git clone git://github.com/wting/dotvim.git ~/.vim

2. Create the new .vimrc file.

	ln -s ~/.vim/.vimrc ~/.vimrc

## Plugins

- [Command-T](http://www.vim.org/scripts/script.php?script_id=3025): Activated by `shift t` in command mode, provides fast file open.
- [CSApprox](http://www.vim.org/scripts/script.php?script_id=2390): Brings gvim color schemes into terminal vim.
- [fugitive](http://www.vim.org/scripts/script.php?script_id=2975): Git wrapper
- [Indent Guides](http://www.vim.org/scripts/script.php?script_id=3361): Visually displays indentation levels.
- [Local vimrc](http://www.vim.org/scripts/script.php?script_id=441): Sources .lvimrc after .vimrc to allow for project / directory specific vim settings.
- [NERD commenter](http://www.vim.org/scripts/script.php?script_id=1218): block commenting with <leader>c<space>, amongst other features
- [NERD tree](http://www.vim.org/scripts/script.php?script_id=1658): file tree
- [Rainbow Parentheses](http://www.vim.org/scripts/script.php?script_id=3772): Matching color parentheses
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540): Implements TextMate snippets feature, [quick intro](http://vimeo.com/3535418).
- [Syntastic](http://www.vim.org/scripts/script.php?script_id=2736): Syntax checking plugin.
- [vimwiki](http://www.vim.org/scripts/script.php?script_id=2226): Personalized wiki within vim, [quick reference](http://vimwiki.googlecode.com/hg/misc/Vimwiki1.1.1QR.pdf).
- [vundle](https://github.com/gmarik/vundle): vim plugin package management system

## Themes

The selected color scheme is [zenburn](http://slinky.imukuppi.org/zenburnpage/), a low-contrast theme primarily for dark environments. Others are listed in `~/.vim/colors/`.

![zenburn color scheme](http://slinky.imukuppi.org/wpress/wp-content/uploads/2008/04/zenburn.png "zenburn")

## Issues

### Command-T

Plugin requires vim to be built with +Ruby.  Most gvim packages have +Ruby support, so installing these packages will usually solve the problem. Depending on the distro, these packages are called: `vim-enhanced`, `vim-gtk`, `vim-gnome`.

For more info, refer to the [plugin page](http://www.vim.org/scripts/script.php?script_id=3025).

### CSApprox

If you cannot load custom color schemes or are get this error message:

    CSApprox needs gui support - not loading.
        See :help |csapprox-+gui| for possible workarounds.
    Press ENTER or type command to continue

Plugin requires vim to be built with +gui.  Depending on the distro, please install one of the following packages: `vim-enhanced`, `vim-gtk`, `vim-gnome`.

Enjoy!
