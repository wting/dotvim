.PHONY: all

all: install fonts
	@-[ -L ~/.vimrc ] && rm ~/.vimrc
	@-mv ~/.vimrc ~/.vimrc.bak
	ln -sfv ~/.vim/.vimrc ~/.vimrc

vundle:
	@-rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

install: vundle
	@echo "Installing vim plugins..."
	vim +BundleInstall +qall

update: clean
	@echo "Updating vim plugins..."
	vim +BundleInstall! +qall

clean:
	@echo "Removing unused vim plguins..."
	vim +BundleClean! +qall

# required for powerline
fonts:
	fc-cache -vf ~/.fonts
