## Quick Start for Claude

Run from a project directory you are comfortable letting Claude edit:

```bash
inbox claude -p work -n
```

Follow the CLI login instructions. Open the displayed URL in your host browser and enter a verification code if requested. Authentication saved in the container home persists under `~/.inbox/claude-work`.

Exit and run the same command to reuse it. Use `-p personal` for a separate login and settings.

InBox normally adds `--dangerously-skip-permissions`; `-n` omits it. Bypass mode is not required by Docker. See the [security model](../security.md).


[Documentation index](../README.md) · [Manage profiles](../profiles.md)
