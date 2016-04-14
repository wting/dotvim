.PHONY: all

upgrade:
	@echo "Updating branch..."
	git pull
	@echo "Removing unused plugins..."
	vim +PluginClean! +qall
	@echo "Updating plugins..."
	vim +PluginInstall! +qall

full-upgrade: upgrade
	./vim_user_install.sh

plugins-clean:
	@echo "Removing unused plugins..."
	vim +BundleClean! +qall

plugins-install:
	@echo "Installing plugins..."
	vim +BundleInstall +qall

plugins-purge:
	@echo "Removing all plugins..."
	@-rm -rf ~/.vim/bundle/

plugins-upgrade:
	@echo "Installing plugins..."
	vim +PluginInstall +qall

install: vundle fonts
	@-[ -L ~/.vimrc ] && rm ~/.vimrc
	@-[ -f ~/.vimrc ] && mv -v ~/.vimrc ~/.vimrc.bak.${RANDOM}
	ln -sfv ~/.vim/.vimrc ~/.vimrc

reinstall: plugins-purge install

vundle:
	@-rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# required for powerline
fonts:
	fc-cache -vf ~/.fonts
