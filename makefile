PREFIX = $(HOME)
CONFIG = $(HOME)/.config

.MAIN: help

# TODO: better logging...

help:
	@echo 'I know how to do the following targets\n' \
		'  all   all of the items below\n' \
		'  vim   vimrc and plugins\n'

vim: vim-plug vimrc
	@echo -n "[INFO] installing vim plugins ... "
	@vim -c 'PlugInstall' -c 'sleep 2' -c 'qa!'
	@echo 'passed'

vimrc:
	@echo -n "[INFO] installing vimrc ... "
	@cp vim/vimrc $(PREFIX)/.vimrc
	@chmod 600 $(PREFIX)/.vimrc
	@echo passed

vim-plug:
	@echo -n "[INFO] installing vim-plug ... "
	@curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
		|| { echo failed!; echo "[ERROR] unable to install vim-plug"; exit 1; }
	@echo "passed"

.PHONY: help vim vimrc vim-plug
