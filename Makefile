.PHONY: all

all: install fonts
	@-[ -L ~/.vimrc ] && rm ~/.vimrc
	@-mv ~/.vimrc ~/.vimrc.bak
	ln -sfv ~/.vim/.vimrc ~/.vimrc

vundle:
	@-rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

install: vundle
	@echo "Installing plugins..."
	vim +BundleInstall +qall

qinstall:
	@echo "Installing plugins..."
	vim +BundleInstall +qall

reinstall: purge install

upgrade: clean
	@echo "Updating plugins..."
	vim +BundleInstall! +qall

clean:
	@echo "Removing unused plugins..."
	vim +BundleClean! +qall

purge:
	@echo "Removing all plugins..."
	@-rm -rf ~/.vim/bundle/

# required for powerline
fonts:
	fc-cache -vf ~/.fonts
