## Using Memory Files with Codex

Save instructions in a file so Codex can reuse them across sessions.
These steps use the `work` profile.

<a id="profile-instructions"></a>
### Setup

1. In your host terminal, create the instruction file if needed. Existing content is kept:

   ```bash
   mkdir -p ~/.inbox/codex-work/.codex
   touch ~/.inbox/codex-work/.codex/AGENTS.md
   ```

2. Open that file in your editor. Add your instructions without removing existing ones:

   ```markdown
   Respond in Japanese.
   Run the relevant tests after changing code.
   ```

3. Restart the same profile:

   ```bash
   inbox codex -p work -n
   ```

### File Location

| Profile | File on the host |
| --- | --- |
| `work` | `~/.inbox/codex-work/.codex/AGENTS.md` |
| Unnamed | `~/.inbox/codex/.codex/AGENTS.md` |

Inside the container, the file is at `/home/inbox/.codex/AGENTS.md`.
For the unnamed profile, use its path above and omit `-p work` when starting the agent.

### Project Instructions

Put an `AGENTS.md` in your project for shared project instructions.
Start InBox from that directory so the agent can read it at `/workspace`.

Codex combines profile and project instructions. More specific project guidance takes precedence.
In the same directory, `AGENTS.override.md` takes priority over `AGENTS.md`.
See the [AGENTS.md guide](https://learn.chatgpt.com/docs/agent-configuration/agents-md) for discovery details.

[Documentation index](../README.md) · [Manage profiles](../profiles.md)
