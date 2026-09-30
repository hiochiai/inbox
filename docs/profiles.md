## Create and switch profiles

Keep separate logins and settings by choosing an agent and a profile name. Run these commands in your **host terminal**, from the project you want the agent to work on. You need an installed launcher and a running Docker daemon.

### Create a named profile

1. Start a profile named `work`:

   ```bash
   inbox claude -p work -n
   ```

   InBox creates `$HOME/.inbox/claude-work` if needed and mounts it at `/home/inbox`. Follow the [Claude login guide](./claude/getting_started.md), then exit the agent.

2. Confirm that the profile exists:

   ```bash
   inbox profile list
   inbox profile claude work
   ```

   The list includes `claude (work)`. The second command prints a path ending in `.inbox/claude-work`.

Replace `claude` with another supported agent to create its own separate home. Use simple names such as `work` or `personal`.

### Switch or return to a profile

Exit the current session before starting the next:

```bash
# Separate login and settings
inbox claude -p personal -n
```

```bash
# Reuse the work profile after exiting the personal session
inbox claude -p work -n
```

Saved home-directory state is reused. The project is always the directory from which you launch; switching profiles does not create a separate project copy.

### Use the unnamed profile

```bash
inbox claude -n
```

This uses `$HOME/.inbox/claude`, even if you configured a default named profile. To choose what bare `inbox` launches, follow [set default startup](./default_startup.md).

### Locate files before editing them

For named profiles, always supply both names:

```bash
inbox profile claude work
```

For the unnamed Claude home, use `$HOME/.inbox/claude` directly. `inbox profile claude` inherits any configured default profile name, including one configured for a different agent. Printing a path does not create the directory.

[Documentation index](./README.md) · [Profile and container model](./profile_model.md) · [Command reference](./cli_reference.md)

Create examples: [claude](./claude/creating_profiles.md) · [codex](./codex/creating_profiles.md) · [antigravity](./antigravity/creating_profiles.md) · [gemini](./gemini/creating_profiles.md).

Switch examples: [claude](./claude/switching_profiles.md) · [codex](./codex/switching_profiles.md) · [antigravity](./antigravity/switching_profiles.md) · [gemini](./gemini/switching_profiles.md).
