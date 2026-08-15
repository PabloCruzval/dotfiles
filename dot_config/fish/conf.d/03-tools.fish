fzf --fish | source

if command -q zoxide
    zoxide init --cmd=cd fish | source
end

if command -q bat
    alias cat 'bat --style=plain'
end

if command -q fd
    alias find 'fd'
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
end

if command -q rg
    alias grep 'rg'
end

alias ls='eza --color=always --group-directories-first --icons=always'
