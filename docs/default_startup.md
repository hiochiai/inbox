## Default Profile Startup

Run `inbox profile set-default <agent> [<profile>]` to choose the agent and profile started by `inbox` without arguments. Creating a profile does not automatically make it the default. If no default is set, `inbox` displays its usage information.

```bash
# Use the default Codex profile when running inbox without arguments
inbox profile set-default codex
inbox

# Show the current default
inbox profile default
```
