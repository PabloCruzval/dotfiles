zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

zinit ice wait lucid; zinit snippet OMZP::sudo
zinit ice wait lucid; zinit snippet OMZP::command-not-found

autoload -Uz compinit
if [[ ! -f ${ZDOTDIR:-$HOME}/.zcompdump ]] || [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zinit cdreplay -q
