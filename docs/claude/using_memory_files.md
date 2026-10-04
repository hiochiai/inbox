## Using Memory Files with Claude

Save instructions in a file so Claude can reuse them across sessions.
These steps use the `work` profile.

### Setup

1. In your host terminal, create the instruction file if needed. Existing content is kept:

   ```bash
   mkdir -p ~/.inbox/claude-work/.claude
   touch ~/.inbox/claude-work/.claude/CLAUDE.md
   ```

2. Open that file in your editor. Add your instructions without removing existing ones:

   ```markdown
   Respond in Japanese.
   Run the relevant tests after changing code.
   ```

3. Restart the same profile:

   ```bash
   inbox claude -p work -n
   ```

### File Location

| Profile | File on the host |
| --- | --- |
| `work` | `~/.inbox/claude-work/.claude/CLAUDE.md` |
| Unnamed | `~/.inbox/claude/.claude/CLAUDE.md` |

Inside the container, the file is at `/home/inbox/.claude/CLAUDE.md`.
For the unnamed profile, use its path above and omit `-p work` when starting the agent.

<a id="how-it-works"></a>
The agent reads this file when starting. Rename or remove this file to stop loading these profile instructions.

[Documentation index](../README.md) · [Manage profiles](../profiles.md)
