## Disable non-essential trafice

To disable non-essential traffic, add the following configuration:
```bash
cat << EOF > ~/.inbox/claude/.claude/settings.json
{
  "env": {
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
EOF
```