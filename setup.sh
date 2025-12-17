#!/bin/bash

readonly CHEZMOI_PATH="$HOME/.local/share/chezmoi"
readonly DEPENDENCIES=( "chezmoi" "quickshell" "rofi" "kitty" )

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

for pkg in "${DEPENDENCIES[@]}"; do
	if ! command -v "$pkg" &> /dev/null; then
		sudo pacman -S "$pkg"
	else
		echo "$pkg is already installed."
	fi
done

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
	backup "$HOME/.config/${dir##*/}"
done

