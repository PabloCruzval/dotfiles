export EDITOR='nvim'

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export CLICOLOR=1

export GPG_TTY=$(tty)

export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

case ":$PATH:" in
  *":$HOME/.local/share/pnpm:"*) ;;
  *) export PATH="$HOME/.local/share/pnpm:$PATH" ;;
esac

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export PATH="$HOME/.opencode/bin:$PATH"
