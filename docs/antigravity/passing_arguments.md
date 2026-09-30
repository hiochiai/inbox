## Passing arguments to antigravity

Put all agent arguments after `--`. Before it, only InBox options are accepted.

```bash
# Agent help and version
inbox antigravity -- --help
inbox antigravity -- --version

# Select the InBox profile, then pass options to the agent
inbox antigravity -p work -n -- --help
```

The first `--` is consumed by InBox. Everything after it is forwarded unchanged, including another `--`, empty strings, and options such as `-p`, `-n`, `-A`, or `-D`. Before the separator, these options belong to InBox. Unknown options and positional arguments before it are errors, even if the agent accepts them.

### Defaults

InBox adds `--dangerously-skip-permissions` by default. Use `-n` before the separator to omit it; approval behavior then depends on the agent configuration. The separator itself does not disable defaults.

```bash
inbox antigravity -n
```

### Migration from v0.14.1

This source revision requires the separator for agent arguments. Replace `inbox antigravity --help` with `inbox antigravity -- --help`. The v0.14.1 release forwards unknown arguments implicitly and does not support this separator. Until a new release is published, use [source installation](../installation.md#from-a-checkout).
