.PHONY: all

all: vundle command-t fonts
	@-mv ~/.vimrc ~/.vimrc.bak
	ln -sfv ~/.vim/.vimrc ~/.vimrc

vundle:
	@-rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@echo "Installing / updating vim plugins found in ~/.vimrc..."
	vim -c ":execute 'BundleInstall!' | qa"

command-t:
	sh ./command-t.sh

# required for powerline plugin
fonts:
	fc-cache -vf ~/.fonts
