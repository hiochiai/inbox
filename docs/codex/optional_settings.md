## Optional Codex Settings

Edit `~/.inbox/codex/.codex/config.toml` for the unnamed InBox profile, or `~/.inbox/codex-personal/.codex/config.toml` for a profile named `personal`.

```bash
# Create the configuration file without replacing existing content
mkdir -p ~/.inbox/codex/.codex
touch ~/.inbox/codex/.codex/config.toml
```

For example, add or update this top-level setting to disable Codex's web search tool:

```toml
web_search = "disabled"
```

This setting controls the web search tool; it does not disable network access for shell commands. Restart Codex to use the updated configuration.

For a single session, override the setting on the command line:

```bash
# Disable web search for this session
inbox codex -- -c 'web_search="disabled"'
```

CLI arguments override file settings. To use approval or sandbox settings from your configuration, omit InBox's default bypass flag with `inbox codex -n`.

See the [official configuration guide](https://learn.chatgpt.com/docs/config-file/config-basic) for available settings and precedence.
