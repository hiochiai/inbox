## Passing Arguments to Claude

You can pass arguments directly to the Claude agent. Any arguments that are not recognized by `inbox` will be passed to the agent.

```bash
# Get the version of the Claude agent
inbox claude --version
```

### Default Arguments

By default, `inbox` starts the Claude agent with the `--dangerously-skip-permissions` flag to skip permission prompts. This is optional, not a container requirement; the mounted project remains writable.

If you need to run the agent without this default, use the `-n` or `--no-defaults` flag.

```bash
# Run Claude without any default arguments
inbox claude -n
```
