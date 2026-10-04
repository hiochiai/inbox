## Run your first persistent agent session

Start Claude, sign in, and return to the same profile later.
A profile stores your login and settings between sessions.

### Before you start

[Install InBox](./installation.md) and start Docker. You also need access to Claude's provider.
Run the commands below in your host terminal, from a project the agent may edit.

### Start and return to a session

1. Check that InBox and Docker are available:

   ```bash
   inbox version
   docker info
   ```

   Expect an InBox version and Docker server information.

2. Start a profile named `work`:

   ```bash
   inbox claude -p work -n
   ```

   The first run may download an image. InBox creates `~/.inbox/claude-work` and starts Claude.
   `-n` omits InBox's default flag that skips approvals. Your project and profile are still writable.

3. Follow the login prompts. Open the displayed URL in your browser when requested.
   Ask Claude to explain the project. Provider usage charges may apply.

4. Exit Claude, then check the saved profile:

   ```bash
   inbox profile list
   inbox profile claude work
   ```

   Expect `claude (work)` and a path ending in `.inbox/claude-work`.

5. Start the same profile again:

   ```bash
   inbox claude -p work -n
   ```

   Your saved login and settings remain available. The provider may ask you to sign in again.

Next: [create a personal profile](./profiles.md) or [learn what persists](./profile_model.md).
For other agents, choose a [login guide](./README.md#agent-specific-guides).

[Documentation index](./README.md) · [Troubleshoot startup](./installation.md#troubleshooting)
