.PHONY: all

all: vundle command-t
	rm ~/.vimrc
	ln -s ~/.vim/.vimrc ~/.vimrc

vundle:
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

command-t:
	sh ./command-t_compile.sh
