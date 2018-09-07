.PHONY: all

upgrade:
	@echo "Updating branch..."
	git pull
	@echo "Removing unused plugins..."
	vim +VundleClean! +qall
	@echo "Updating plugins..."
	vim +VundleInstall! +qall

full-upgrade: upgrade
	./vim_user_install.sh

plugins-clean: vundle
	@echo "Removing unused plugins..."
	vim +VundleClean! +qall

plugins-install: vundle
	@echo "Installing plugins..."
	vim +VundleInstall +qall

plugins-purge:
	@echo "Removing all plugins..."
	@-rm -rf ~/.vim/bundle/

plugins-upgrade: vundle
	@echo "Installing plugins..."
	vim +VundleUpdate +qall

install: vundle fonts
	@-[ -L ~/.vimrc ] && rm ~/.vimrc
	@-[ -f ~/.vimrc ] && mv -v ~/.vimrc ~/.vimrc.bak.${RANDOM}
	ln -sfv ~/.vim/.vimrc ~/.vimrc

reinstall: plugins-purge install

vundle:
	git clone git@github.com:VundleVim/Vundle.vim.git ./vundle/Vundle.vim

# required for powerline
fonts:
	# ignore for OSX
	-fc-cache -vf ~/.fonts
