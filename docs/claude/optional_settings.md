## Disabling Non-Essential Traffic

Merge the following `env` entry into your existing profile settings; preserve other settings. This does not restrict shell-command network access. For a new unnamed profile only:
```bash
mkdir -p ~/.inbox/claude/.claude
# Only run this when settings.json does not already exist
cat << EOF > ~/.inbox/claude/.claude/settings.json
{
  "env": {
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
EOF
```