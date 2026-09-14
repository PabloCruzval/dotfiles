function clipcat --argument file
    cat $file | xclip -selection clipboard
end

function devstart
    set -l cmd (string join ' ' $argv)
    set -q cmd[1]; or set cmd 'npm run dev'
    set -l name (basename $PWD)

    pm2 start "$cmd" --name "$name" --cwd "$PWD"
end
