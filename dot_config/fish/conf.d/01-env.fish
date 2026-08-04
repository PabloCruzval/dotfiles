set -gx EDITOR nvim

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx CLICOLOR 1

set -gx GPG_TTY (tty)

set -gx PYTHONDONTWRITEBYTECODE 1
set -gx PYTHONUNBUFFERED 1

fish_add_path ~/.bun/bin
fish_add_path ~/.local/share/pnpm
fish_add_path ~/.local/share/bob/nvim-bin
fish_add_path ~/.opencode/bin

set -gx BUN_INSTALL $HOME/.bun
