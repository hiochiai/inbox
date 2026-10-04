## Disabling Non-Essential Traffic

Edit settings for the `work` profile in your host terminal.
This setting affects Claude's optional traffic. It does not block network access from shell commands.

1. Create the settings file if needed, keeping existing content:

   ```bash
   mkdir -p ~/.inbox/claude-work/.claude
   touch ~/.inbox/claude-work/.claude/settings.json
   ```

2. Open the file in your editor. Add this entry to the existing `env` object, or create that object:

   ```json
   {
     "env": {
       "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
     }
   }
   ```

   Keep all other settings and environment entries.

3. Restart the same profile:

   ```bash
   inbox claude -p work -n
   ```

For the unnamed profile, replace `claude-work` with `claude` in the paths and omit `-p work`.

[Documentation index](../README.md) · [Manage profiles](../profiles.md)
