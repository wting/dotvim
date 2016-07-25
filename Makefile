.PHONY: all

upgrade:
	@echo "Updating branch..."
	git pull
	@echo "Removing unused plugins..."
	vim +BundleClean! +qall
	@echo "Updating plugins..."
	vim +BundleInstall! +qall

full-upgrade: upgrade
	./vim_user_install.sh

plugins-clean: bundle/vundle
	@echo "Removing unused plugins..."
	vim +BundleClean! +qall

plugins-install: bundle/vundle
	@echo "Installing plugins..."
	vim +BundleInstall +qall

plugins-purge:
	@echo "Removing all plugins..."
	@-rm -rf ~/.vim/bundle/

plugins-upgrade: bundle/vundle
	@echo "Installing plugins..."
	vim +BundleUpdate +qall

install: bundle/vundle fonts
	@-[ -L ~/.vimrc ] && rm ~/.vimrc
	@-[ -f ~/.vimrc ] && mv -v ~/.vimrc ~/.vimrc.bak.${RANDOM}
	ln -sfv ~/.vim/.vimrc ~/.vimrc

reinstall: plugins-purge install

bundle/vundle:
	git clone https://github.com/gmarik/vundle.git ./bundle/vundle

# required for powerline
fonts:
	# ignore for OSX
	-fc-cache -vf ~/.fonts
