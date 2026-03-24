function agent-notify --description "Send a floating notification for coding agents (bypasses DND, no focus steal)"
    set -l title $argv[1]
    set -l message $argv[2]
    set -l repo_name (basename (pwd))
    set -l socket (ls /tmp/mykitty-* 2>/dev/null | head -1)
    if test -n "$socket"
        set -l window_id (kitten @ --to unix:$socket ls 2>/dev/null | python3 -c "
import json,sys
data = json.load(sys.stdin)
for os_win in data:
    for tab in os_win.get('tabs', []):
        for win in tab.get('windows', []):
            if win.get('is_active') and tab.get('is_active'):
                print(win['id'])
                sys.exit()
" 2>/dev/null)
        if test -n "$window_id"
            ~/.local/bin/agent-notify "$title — $repo_name" "$message" "$window_id" &
            return
        end
    end
    ~/.local/bin/agent-notify "$title — $repo_name" "$message" &
end
