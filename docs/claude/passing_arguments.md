## Passing arguments to claude

Put all agent arguments after `--`. Before it, only InBox options are accepted.

```bash
# Agent help and version
inbox claude -- --help
inbox claude -- --version

# Select the InBox profile, then pass options to the agent
inbox claude -p work -n -- --help
```

The first `--` is consumed by InBox. Everything after it is forwarded unchanged, including another `--`, empty strings, and options such as `-p`, `-n`, `-A`, or `-D`. Before the separator, these options belong to InBox. Unknown options and positional arguments before it are errors, even if the agent accepts them.

### Defaults

InBox adds `--dangerously-skip-permissions` by default. Use `-n` before the separator to omit it; approval behavior then depends on the agent configuration. The separator itself does not disable defaults.

```bash
inbox claude -n
```

### Migration from v0.14.1

InBox v0.15.0 and newer require the separator for agent arguments. Replace `inbox claude --help` with `inbox claude -- --help`. The v0.14.1 release forwards unknown arguments implicitly and does not support this separator. Use v0.15.0 or newer for this syntax.
