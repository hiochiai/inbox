## Create and switch profiles

A profile stores one agent's login and settings. Use separate profiles for work and personal accounts.
Run these commands in your host terminal with InBox installed and Docker running.

### Create a named profile

1. From your project directory, start the `work` profile:

   ```bash
   inbox claude -p work -n
   ```

   InBox creates `~/.inbox/claude-work` if needed. Follow the login prompts, then exit the agent.
   `-n` omits the default flag that skips approvals. The agent can still edit your project.

2. Check the profile:

   ```bash
   inbox profile list
   inbox profile claude work
   ```

   Expect `claude (work)` and a path ending in `.inbox/claude-work`.

Replace `claude` with another supported agent to create that agent's profile.
Use simple names such as `work` or `personal`.

### Switch or return to a profile

Exit your current session before starting another profile:

```bash
inbox claude -p personal -n
```

To return to work, exit again and run:

```bash
inbox claude -p work -n
```

Switching profiles changes the login and settings. It does not copy your project.
The agent always works on the directory where you start InBox.

### Use the unnamed profile

```bash
inbox claude -n
```

Without `-p`, Claude uses `~/.inbox/claude`. This is the **unnamed profile**.
It does not follow the saved default. To choose what `inbox` with no arguments starts, [set default startup](./default_startup.md).

### Locate files before editing them

Always include the agent and profile name:

```bash
inbox profile claude work
```

This prints the directory without creating it. For the unnamed Claude profile, use `~/.inbox/claude` directly.
Omitting the name from `inbox profile claude` has different behavior; see the [command reference](./cli_reference.md#manage-profiles-and-the-launcher).

[Documentation index](./README.md) · [What persists](./profile_model.md)

Agent examples: create profiles for [Claude](./claude/creating_profiles.md), [Codex](./codex/creating_profiles.md), [Antigravity](./antigravity/creating_profiles.md), or [Gemini](./gemini/creating_profiles.md).
Switch profiles for [Claude](./claude/switching_profiles.md), [Codex](./codex/switching_profiles.md), [Antigravity](./antigravity/switching_profiles.md), or [Gemini](./gemini/switching_profiles.md).
