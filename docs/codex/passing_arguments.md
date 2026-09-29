## Passing Arguments to Codex

Arguments that InBox does not recognize are passed to Codex.

```bash
# Show Codex help and version
inbox codex --help
inbox codex --version

# Start a session with an initial prompt
inbox codex "Explain this project"
```

InBox handles `-p` / `--profile` itself: these select an InBox profile, not Codex's own configuration profile. InBox also consumes `-n`, `-A`, and `-D`; see `inbox --help` for these options.

### Default Arguments

InBox adds `--dangerously-bypass-approvals-and-sandbox` by default. Codex can run commands and modify the mounted project without approval prompts or its own sandbox.

Use `-n` or `--no-defaults` to omit this argument:

```bash
# Run Codex without InBox's default argument
inbox codex -n
```
