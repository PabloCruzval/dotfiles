#!/bin/bash

readonly CHEZMOI_PATH="$HOME/.local/share/chezmoi"


function promptyn () {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function cleanup() {
	rm -rf "$1"
	echo "Clean up $1"
}

function backup(){
	if [ ! -d "$1" ]; then
		return 0
	fi
	if [ ! -d "$CHEZMOI_PATH/.backup" ]; then
		mkdir -p "$CHEZMOI_PATH/.backup"
	fi
	mv "$1" "$CHEZMOI_PATH/.backup/"
	printf "\n[NOTICE]: Your ${1##*/} config has been saved in $CHEZMOI_PATH/.backup\n"
}


echo "Starting Nyx's dotfiles setup"

if pacman -Qs "chezmoi" > /dev/null; then
    echo "The package is installed"
else
    echo "The package is NOT installed"
	if promptyn "Want to install? (y: yes, n: no): "; then
		sudo pacman -S "chezmoi"
	else
		echo "Task aborted"
		exit 0
	fi
fi

if [ ! -d $CHEZMOI_PATH ]; then
	git clone "https://github.com/PabloCruzval/dotfiles" $CHEZMOI_PATH
else
	mv "$CHEZMOI_PATH" "${CHEZMOI_PATH}_old"
	mkdir "$CHEZMOI_PATH"
	git clone "https://github.com/PabloCruzval/dotfiles" "$CHEZMOI_PATH"
	mkdir -p "$CHEZMOI_PATH/.backup"
	mv "${CHEZMOI_PATH}_old" "$CHEZMOI_PATH/.backup/"
fi

CONFIG_DIRS=( "$CHEZMOI_PATH/dot_config"/* )

for dir in "${CONFIG_DIRS[@]}"; do
	backup $dir
done

printf "\nSetup done, for apply the config please run:\nchezmoi apply\n"
