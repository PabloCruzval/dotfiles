#compdef -P pip[0-9.]#
__pip() {
  compadd $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$((CURRENT-1)) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null )
}
if [[ $zsh_eval_context[-1] == loadautofunc ]]; then
  __pip "$@"
else
  compdef __pip -P 'pip[0-9.]#'
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' list-max-items 20

zstyle ':fzf-tab:*' fzf-flags --border --height=60% --layout=reverse --preview-window=right,60%,wrap
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons $realpath'

zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word'
zstyle ':fzf-tab:complete:git-log:*'   fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-show:*'  fzf-preview 'git show --color=always $word'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'case "$group" in "modified file") git diff $word ;; "recent commit object name") git show --color=always $word ;; *) git log --color=always $word ;; esac'
zstyle ':completion:*:git-checkout:*' sort false
