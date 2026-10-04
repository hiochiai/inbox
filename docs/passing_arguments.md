## Pass arguments to an agent

Put InBox options before `--`. Put the agent's options and prompt after it.
These examples require InBox v0.15.0 or newer.

Run this in your host terminal to show Claude's help:

```bash
inbox claude -p work -n -- --help
```

For a prompt, use Claude's own `-p` option after the separator:

```bash
inbox claude -p work -n -- -p "Explain this project"
```

The first `-p work` selects the InBox profile. The second `-p` sends a prompt to Claude.
The prompt requires a logged-in profile and provider access.

See the [CLI reference](./cli_reference.md#launch-an-agent) for all argument rules and [migration examples](./cli_reference.md#argument-migration).
For jobs without a terminal, use [images directly in CI](./running_in_ci.md).

[Documentation index](./README.md) · [Manage profiles](./profiles.md)

Agent examples: [Claude](./claude/passing_arguments.md), [Codex](./codex/passing_arguments.md), [Antigravity](./antigravity/passing_arguments.md), [Gemini](./gemini/passing_arguments.md).
