## Agent handoff verification record

These checks were recorded on 2026-09-29. They are not a guarantee for later image contents.
For the usage steps, see [Ask another agent](./README.md).

### Environment

| Component | Recorded value |
| --- | --- |
| Docker | 29.8.0 |
| Platform | linux/arm64 |
| Images | `0.14.1-claude` and `0.14.1-codex` |
| Codex | 0.159.0 |

### Checks completed

A non-root process in the Claude image started the Codex image through the host Docker socket.
It successfully ran `codex --version`.

Disposable named volumes checked:

- Shared project access.
- Rejection of writes to the child container's project.
- Saved child profile files across runs.
- No Docker socket inside the child container.

The image's `codex exec --help` confirmed the non-interactive command and sandbox flag.

### Limits

These checks used no real credentials and made no model calls.
They did not verify authenticated Claude-to-Codex task completion, the recipe's host bind paths, or macOS/WSL2 socket behavior.
Image tags may change after the recorded date.
