function clipcat --argument file
    wl-copy < $file
end

function devstart
    set -l cmd (string join ' ' $argv)
    set -q cmd[1]; or set cmd 'npm run dev'
    set -l name (basename $PWD)

    pm2 start "$cmd" --name "$name" --cwd "$PWD"
end

function mux
    if test (count $argv) -gt 0
        sesh connect $argv[1]
    else
        set -l session (sesh list --icons | fzf --no-sort --ansi \
            --border-label ' sesh ' \
            --prompt '⚡ ' \
            --header ' ^a all ^t tmux ^g configs ^x zoxide' \
            --bind 'tab:down,btab:up' \
            --bind 'ctrl-a:change-prompt(⚡ )+reload(sesh list --icons)' \
            --bind 'ctrl-t:change-prompt(🪟 )+reload(sesh list -t --icons)' \
            --bind 'ctrl-g:change-prompt(⚙️ )+reload(sesh list -c --icons)' \
            --bind 'ctrl-x:change-prompt(📁 )+reload(sesh list -z --icons)' \
            --preview 'sesh preview {}' \
            --preview-window 'right:55%')
        test -n "$session"; and sesh connect $session
    end
end

function zr
    set -l db "$HOME/.local/share/zathura/bookmarks.sqlite"
    if not test -f "$db"
        echo "No hay historial de Zathura todavía."
        return 1
    end

    set -l file (sqlite3 -batch -noheader -list "$db" "SELECT DISTINCT file FROM fileinfo ORDER BY time DESC;" 2>/dev/null | fzf --prompt="PDFs recientes > ")
    test -n "$file"; and zathura "$file" &
end
