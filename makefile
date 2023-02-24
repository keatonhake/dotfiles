PREFIX = $(HOME)
CONFIG = $(HOME)/.config

.MAIN: help

# TODO: better logging...

help:
	@printf '%s\n' 'I know how to make the following targets' \
		'  all     all of the non-clean items below' \
		'  vim     vimrc and plugins' \
		'  clean   try to cleanup configs'

all: vim

vim: vim-plug vimrc
	@echo -n "[INFO] installing vim plugins ... "
	@vim -c 'PlugInstall' -c 'sleep 2' -c 'qa!' >/dev/null 2>&1
	@echo 'passed'
	@sed -i 's/"colorscheme/colorscheme/' $(PREFIX)/.vimrc

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

clean-vim:
	rm -rf $(PREFIX)/.vimrc $(PREFIX)/.vim

clean: clean-vim


.PHONY: help vim vimrc vim-plug clean clean-vim
