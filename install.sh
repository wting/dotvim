#!/usr/bin/env sh

replace=

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

if [ ${replace} ]; then
	rm -rfv ~/.vim/ 2>/dev/null
	rm -v ~/.vim/ 2>/dev/null
	rm -v ~/.vimrc 2>/dev/null
else
	timestamp=`/usr/bin/env date +%s`
	if [ -d ~/.vim ] || [ -h ~/.vim ]; then
		echo -e "\nExisting ~/.vim/, moving to backup location ...\n"
		mv -v ~/.vim ~/.vim-backup-${timestamp}
	fi

	if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
		echo -e "\nExisting ~/.vimrc, moving to backup location ...\n"
		mv -v ~/.vimrc ~/.vimrc-backup-${timestamp}
	fi
fi

echo -e "\nCloning dotvim repository into ~/.vim/ ...\n"
if [ `whoami` == "ting" ]; then
	# private read/write repo
	/usr/bin/env git clone git@github.com:wting/dotvim.git ~/.vim/
else
	# public read only repo
	/usr/bin/env git clone https://github.com/wting/dotvim.git/ ~/.vim/
fi

echo -e "\nSymlinking ~/.vimrc ...\n"
ln -s ~/.vim/.vimrc ~/.vimrc
