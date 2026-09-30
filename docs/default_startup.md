## Set default startup

Choose the agent and profile started by `inbox` without arguments. Creating a profile does not automatically make it the default. Run these commands in your **host terminal** after installing InBox.

1. Select a named profile:

   ```bash
   inbox profile set-default claude work
   ```

2. Check the saved selection:

   ```bash
   inbox profile default
   ```

   Expected output:

   ```text
   Default Agent: claude
   Default Profile: work
   ```

3. From your project directory, launch the selection:

   ```bash
   inbox
   ```

   Bare `inbox` adds the agent's default approval-bypass flag. To omit it, explicitly run `inbox claude -p work -n` instead. Bare `inbox` also does not enable SSH or Docker socket forwarding.

To select an unnamed home, omit the profile in `inbox profile set-default claude`. Explicit `inbox claude` always uses the unnamed home, regardless of the saved default. Setting a default does not create the profile directory; launch creates it.

Without a saved default, bare `inbox` prints usage and exits with status 1.

[Documentation index](./README.md) · [Manage profiles](./profiles.md) · [Default flags](./cli_reference.md#launch-an-agent)

Default examples: [claude](./claude/setting_default_profile.md) · [codex](./codex/setting_default_profile.md) · [antigravity](./antigravity/setting_default_profile.md) · [gemini](./gemini/setting_default_profile.md).
