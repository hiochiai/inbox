## Using Memory Files with Codex

Use `AGENTS.md` to provide instructions that Codex reads at the start of each session.

### Profile Instructions

1. Create the file for your default InBox profile:

   ```bash
   # Create the directory and instruction file without replacing existing content
   mkdir -p ~/.inbox/codex/.codex
   touch ~/.inbox/codex/.codex/AGENTS.md
   ```

2. Edit the file and add your preferences, for example:

   ```markdown
   Respond in Japanese.
   Run the relevant tests after changing code.
   ```

For a named profile such as `personal`, use `~/.inbox/codex-personal/.codex/AGENTS.md`. Inside the container, either profile's file appears at `/home/inbox/.codex/AGENTS.md`.

### Project Instructions

Place an `AGENTS.md` in your project directory for shared project instructions. Start `inbox codex` from that directory so it is mounted at `/workspace`.

Codex combines profile and project instructions; more specific project guidance takes precedence. An `AGENTS.override.md` in the same directory takes priority over `AGENTS.md`. Restart Codex after editing instructions.

See the [official AGENTS.md guide](https://learn.chatgpt.com/docs/agent-configuration/agents-md) for instruction discovery details.


[Documentation index](../README.md) · [Manage profiles](../profiles.md)
