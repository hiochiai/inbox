## Passing Arguments to Antigravity

You can pass arguments directly to the Antigravity agent (`agy`) by appending them to the `inbox` command.

### Examples

```bash
# Show version
inbox antigravity --version

# Run a specific prompt non-interactively
inbox antigravity -p "Refactor this file"
```

### Disabling Default Arguments

InBox uses `--dangerously-skip-permissions` by default for Antigravity. To disable this, use `-n` or `--no-defaults`:

```bash
inbox antigravity -n
```
