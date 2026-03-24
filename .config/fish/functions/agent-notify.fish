function agent-notify --description "Send a floating notification for coding agents (bypasses DND, no focus steal)"
    set -l title $argv[1]
    set -l message $argv[2]
    set -l repo_name (basename (pwd))
    ~/.local/bin/agent-notify "$title — $repo_name" "$message" &
end
