alias dot 'chezmoi cd'
alias nv 'nvim'
alias py 'python'
alias ws 'cd ~/Workspace'

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'

alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

alias fix_fcking_lock "hyprctl --instance 0 eval 'hl.clear_crashed_lockscreen()' && sleep 0.1 && hyprctl --instance 0 eval 'hl.dispatch(hl.dsp.exec_cmd(\"hyprlock\"))' && sleep 1 && exit"
