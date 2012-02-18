#!/usr/bin/env sh

replace=true

# Command line parsing
while true; do
	case "${1}" in
		-r|--replace)
			replace=true
			;;
		--)
			shift
			break
			;;
		-*)
			echo "Invalid option: ${1}" 1>&2;
			exit 1
			;;
		*)
			break
			;;
	esac
done

echo -e "\nRemoving existing vim related files ...\n"
if [ -h ~/.vim ]; then
	rm ~/.vim
elif [ -d ~/.vim ]; then
	rm -rf ~/.vim
fi
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
	rm ~/.vimrc
fi

echo -e "\nCloning dotvim repository into ~/.vim/ ...\n"
if [ `whoami` = "ting" ]; then
	# private read/write repo
	/usr/bin/env git clone git@github.com:wting/dotvim.git ~/.vim/
else
	# public read only repo
	/usr/bin/env git clone https://github.com/wting/dotvim.git/ ~/.vim/
fi

echo -e "\nSymlinking ~/.vimrc ...\n"
ln -s ~/.vim/.vimrc ~/.vimrc
