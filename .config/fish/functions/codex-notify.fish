function codex-notify --description "Parse Codex JSON event and send notification"
    set -l json_str $argv[1]
    set -l msg (echo $json_str | python3 -c "import sys,json; e=json.loads(sys.stdin.read()); print(e.get('last-assistant-message', e.get('last_user_message', 'Turn complete'))[:200])")
    agent-notify Codex "$msg"
end
