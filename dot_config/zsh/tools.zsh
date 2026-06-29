alias ls='eza --color=auto --icons --group-directories-first'
alias ll='eza -l --color=auto --icons --group-directories-first'
alias la='eza -la --color=auto --icons --group-directories-first'
alias lt='eza -T --color=auto --icons --group-directories-first'

if command -v bat &>/dev/null; then
    alias cat='bat --style=plain'
fi

if command -v fd &>/dev/null; then
    alias find='fd'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

if command -v rg &>/dev/null; then
    alias grep='rg'
fi
