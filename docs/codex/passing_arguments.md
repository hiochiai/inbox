## Passing arguments to codex

Put all agent arguments after `--`. Before it, only InBox options are accepted.

```bash
# Agent help and version
inbox codex -- --help
inbox codex -- --version

# Select the InBox profile, then pass options to the agent
inbox codex -p work -n -- --help
```

The first `--` is consumed by InBox. Everything after it is forwarded unchanged, including another `--`, empty strings, and options such as `-p`, `-n`, `-A`, or `-D`. Before the separator, these options belong to InBox. Unknown options and positional arguments before it are errors, even if the agent accepts them.

### Defaults

InBox adds `--dangerously-bypass-approvals-and-sandbox` by default. Use `-n` before the separator to omit it; approval behavior then depends on the agent configuration. The separator itself does not disable defaults.

```bash
inbox codex -n
```

### Migration from v0.14.1

This source revision requires the separator for agent arguments. Replace `inbox codex --help` with `inbox codex -- --help`. The v0.14.1 release forwards unknown arguments implicitly and does not support this separator. Until a new release is published, use [source installation](../installation.md#from-a-checkout).
