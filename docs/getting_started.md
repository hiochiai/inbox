## Run your first persistent agent session

In this tutorial, start Claude in a container, save its login in a profile, and return to that profile. You will learn which files survive when the container exits.

### Before you start

You need Bash, curl, a running Docker installation with Linux container support, and access to Claude's provider. Install InBox using the [installation guide](./installation.md). Use a project directory you are comfortable letting the agent edit.

All commands below run in your **host terminal**. Login happens in the agent terminal and your host browser. Your project and profile are writable, even with `-n`.

### Start and return to a session

1. In your project directory, check the launcher and Docker:

   ```bash
   inbox version
   docker info
   ```

   Expect an InBox version and Docker server information. Resolve any daemon connection error before continuing. These instructions require InBox v0.15.0 or newer and its corresponding published images.

2. Start a dedicated profile:

   ```bash
   inbox claude -p work -n
   ```

   The first launch may download an image. InBox reports `Running claude (profile: work)` and opens the agent. `-n` omits InBox's approval-bypass flag.

3. Follow the [Claude authentication instructions](./claude/getting_started.md). Open the displayed URL in your host browser when requested. Once authenticated, ask Claude to explain the current project. A response requires provider access and may incur provider charges.

4. Exit using the agent's exit control. In your host terminal, inspect the profile:

   ```bash
   inbox profile list
   inbox profile claude work
   ```

   Expect `claude (work)` in the list and a path ending in `.inbox/claude-work`. The container has exited, but this directory remains.

5. Start the same profile again:

   ```bash
   inbox claude -p work -n
   ```

   The same home is mounted, so credentials and settings stored there remain available. The provider can still require renewed authentication.

You have reused a persistent home across disposable containers. Next, [create a separate personal profile](./profiles.md), or read [how profiles and containers relate](./profile_model.md).

For another agent, use its login guide: [Codex](./codex/getting_started.md), [Antigravity](./antigravity/getting_started.md), or [Gemini (deprecated)](./gemini/getting_started.md).

[Documentation index](./README.md) · [Troubleshoot startup](./installation.md#troubleshooting)
