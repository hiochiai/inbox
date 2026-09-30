## Pass arguments to an agent

Use `--` to separate InBox options from options or prompts intended for the agent. Requires InBox v0.15.0 or newer.

In your **host terminal**, select the profile before the separator and put agent arguments after it:

```bash
# Request Claude help without adding InBox's approval-bypass flag
inbox claude -p work -n -- --help
```

Check that the output is the agent's help, rather than InBox's usage text. Replace `claude` with `codex`, `antigravity`, or `gemini` to request that agent's help.

For Claude, `-p` after the separator has the agent's meaning (a non-interactive prompt):

```bash
# Requires an authenticated Claude profile and provider access
inbox claude -p work -n -- -p "Explain this project"
```

The first `-p work` selects the InBox home. The second `-p` reaches Claude unchanged. The launcher still allocates a TTY; for headless jobs, use [images directly in CI](./running_in_ci.md).

For all accepted options, default flags, and migration details, see the [CLI reference](./cli_reference.md).

[Documentation index](./README.md) · [Manage profiles](./profiles.md)

Arguments examples: [claude](./claude/passing_arguments.md) · [codex](./codex/passing_arguments.md) · [antigravity](./antigravity/passing_arguments.md) · [gemini](./gemini/passing_arguments.md).
