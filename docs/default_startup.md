## Set default startup

Choose the agent and profile that `inbox` starts with no arguments.
Run these commands in your host terminal after installing InBox.

1. Save your selection:

   ```bash
   inbox profile set-default claude work
   ```

2. Check it:

   ```bash
   inbox profile default
   ```

   Expected output:

   ```text
   Default Agent: claude
   Default Profile: work
   ```

3. From your project directory, start the saved selection:

   ```bash
   inbox
   ```

This uses InBox's default flags that skip agent approvals. To omit them, run `inbox claude -p work -n` instead.
Starting `inbox` with no arguments does not enable SSH or Docker socket access.

Setting a default does not create a profile directory. The first launch creates it.
The unnamed profile is a separate choice; see [profile selection rules](./cli_reference.md#manage-profiles-and-the-launcher).

[Documentation index](./README.md) · [Manage profiles](./profiles.md)

Agent examples: [Claude](./claude/setting_default_profile.md), [Codex](./codex/setting_default_profile.md), [Antigravity](./antigravity/setting_default_profile.md), [Gemini](./gemini/setting_default_profile.md).
