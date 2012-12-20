.PHONY: all

all: vundle command-t
	@-mv ~/.vimrc ~/.vimrc.bak
	ln -sfv ~/.vim/.vimrc ~/.vimrc

vundle:
	@-rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	#@read -p "Install plugins with the vim command :BundleInstall!"
	vim -c BundleInstall

command-t:
	sh ./command-t_compile.sh
