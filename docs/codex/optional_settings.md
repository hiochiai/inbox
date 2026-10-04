## Optional Codex Settings

Edit the `work` profile's settings to control tools such as web search.
Run file commands in your host terminal.

1. Create the configuration file if needed, keeping existing content:

   ```bash
   mkdir -p ~/.inbox/codex-work/.codex
   touch ~/.inbox/codex-work/.codex/config.toml
   ```

2. Open the file in your editor. To disable web search, add or update this top-level setting:

   ```toml
   web_search = "disabled"
   ```

   Keep other settings. This disables the web search tool, not network access from shell commands.

3. Restart the same profile:

   ```bash
   inbox codex -p work -n
   ```

For one session only, use a command-line override:

```bash
inbox codex -p work -n -- -c 'web_search="disabled"'
```

Command-line arguments override file settings. `-n` lets the agent's settings control approvals and its own sandbox.
For the unnamed profile, replace `codex-work` with `codex` in the paths and omit `-p work`.
See the [configuration guide](https://learn.chatgpt.com/docs/config-file/config-basic) for more settings.

[Documentation index](../README.md) · [Manage profiles](../profiles.md)
