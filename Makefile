.PHONY: all

upgrade: plugins-clean
	@echo "Updating branch..."
	git pull
	@echo "Updating plugins..."
	vim +BundleInstall! +qall

full-upgrade: vim upgrade

plugins-clean:
	@echo "Removing unused plugins..."
	vim +BundleClean! +qall

plugins-purge:
	@echo "Removing all plugins..."
	@-rm -rf ~/.vim/bundle/

plugins-upgrade:
	@echo "Installing plugins..."
	vim +BundleInstall +qall

install: vundle fonts
	@-[ -L ~/.vimrc ] && rm ~/.vimrc
	@-[ -f ~/.vimrc ] && mv -v ~/.vimrc ~/.vimrc.bak.${RANDOM}
	ln -sfv ~/.vim/.vimrc ~/.vimrc

reinstall: plugins-purge install

vundle:
	@-rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

vim:
	./vim_user_install.sh

# required for powerline
fonts:
	fc-cache -vf ~/.fonts
