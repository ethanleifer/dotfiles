# dotfiles

Personal dotfiles for Claude Code, Codex, fish shell, and other tools.

## Usage

This repo is **not** symlinked. After making changes here, manually copy files to their actual locations:

```bash
cp .claude/settings.json ~/.claude/settings.json
cp .codex/* ~/.codex/
cp .config/fish/* ~/.config/fish/
cp .local/share/fish/* ~/.local/share/fish/
```

Claude: when updating dotfiles, edit the files in this repo first, then copy them to the corresponding `~/` paths.
