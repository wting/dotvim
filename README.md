
My personal .vimrc and collection of plugins and themes.

## Setup

1. Clone the repository.

        git clone git://github.com/wting/dotvim.git ~/.vim

2. Create the new .vimrc file.

        ln -s ~/.vim/.vimrc ~/.vimrc

3. Install the Vundle plugin.

        cd ~/.vim
        make vundle

4. Install vim plugins via Vundle.

        vim
        :BundleInstall!

5. Compile the Command-T plugin.

        cd ~/.vim
        make command-t

## Plugins

- [vundle][vundle]: vim plugin package management system

### Look & Feel
- [CSApprox][csapprox]: Brings gvim color schemes into terminal vim.
- [Indent Guides][indent]: Visually displays indentation levels.
- [Rainbow Parentheses][rainbow]: Matching color parentheses.
- [Powerline][powerline]: A better, more functional statusline.
- [fugitive][fugitive]: Git wrapper, required by Powerline.

### Additional Features
- [Command-T][command-t]: Activated by `shift t` in command mode, provides fast file open.
- [Surround][surround]: Quoting/parenthesizing made simple.
- [gundo][gundo]: Visual undo tree to jump to alternate undo paths.
- [Local vimrc][local]: Sources .lvimrc after .vimrc to allow for project / directory specific vim settings.
- [NERD commenter][nerd-commenter]: block commenting with <leader>c<space>, amongst other features
- [NERD tree][nerd-tree]: file tree
- [snipMate][snipmate]: Implements TextMate snippets feature, [quick intro](http://vimeo.com/3535418).
- [AutoTag][autotag]: Automatically update ctags file.
- tlib_vim: Utility library, required by ... something.

### Syntax
- [Syntastic][syntastic]: Syntax checking plugin.
- Markdown
- Scala
- Less CSS

## Themes

The selected color scheme is [zenburn](http://slinky.imukuppi.org/zenburnpage/), a low-contrast theme primarily for dark environments. Others are listed in `~/.vim/colors/`.

![zenburn color scheme](http://slinky.imukuppi.org/wpress/wp-content/uploads/2008/04/zenburn.png "zenburn")

## Issues

### Command-T

Plugin requires vim to be built with Ruby support. To check if vim is compiled with Ruby support, run:

    vim --version | grep ruby

If you see `+ruby` then you're fine. If not or you see `-ruby`, then you need to install a different version of vim. Most gvim packages have +Ruby support, so installing these packages will usually solve the problem. Depending on the distro, these packages are typically called: `vim-enhanced`, `vim-gtk`, `vim-gnome`.

For more info, refer to the [Command-T plugin page](http://www.vim.org/scripts/script.php?script_id=3025).

An alternative to Command-T that does not require any additional support is [CtrlP][ctrlp], written entirely in VimL.

### CSApprox

If vim cannot load color schemes or shows this message:

    CSApprox needs gui support - not loading.
    See :help |csapprox-+gui| for possible workarounds.
    Press ENTER or type command to continue

Then the CSApprox plugin requires vim to be built with +gui support. Depending on the distro, please install one of the following packages: `vim-enhanced`, `vim-gtk`, `vim-gnome`.

Enjoy!

[vundle]: https://github.com/gmarik/vundle
[csapprox]: http://www.vim.org/scripts/script.php?script_id=2390
[indent]: http://www.vim.org/scripts/script.php?script_id=3361
[rainbow]: http://www.vim.org/scripts/script.php?script_id=3772
[powerline]: http://www.vim.org/scripts/script.php?script_id=3881
[fugitive]: http://www.vim.org/scripts/script.php?script_id=2975
[command-t]: http://www.vim.org/scripts/script.php?script_id=3025
[local]: http://www.vim.org/scripts/script.php?script_id=441
[nerd-commenter]: http://www.vim.org/scripts/script.php?script_id=1218
[nerd-tree]: http://www.vim.org/scripts/script.php?script_id=1658
[snipmate]: http://www.vim.org/scripts/script.php?script_id=2540
[syntastic]: http://www.vim.org/scripts/script.php?script_id=2736
[gundo]: https://github.com/sjl/gundo.vim
[surround]: https://github.com/tpope/vim-surround/#surroundvim
[autotag]: http://www.vim.org/scripts/script.php?script_id=1343
[ctrlp]: https://github.com/kien/ctrlp.vim
