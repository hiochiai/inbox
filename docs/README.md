## InBox documentation

Choose a task below. Commands run in your host terminal unless a page says otherwise.

### Start here

- [Install InBox](./installation.md) — requirements, installation, updates, and troubleshooting.
- [Run your first session](./getting_started.md) — sign in and return to a saved profile.

### Complete a task

- [Create and switch profiles](./profiles.md)
- [Set default startup](./default_startup.md)
- [Pass agent arguments](./passing_arguments.md)
- [Add tools with a custom image](./custom_images.md)

### Advanced tasks

- [Let an agent use Docker](./docker_outside_of_docker.md)
- [Ask Codex from Claude](../examples/agent-handoff/README.md)
- [Run images in CI](./running_in_ci.md)
- [Configure MCP tools](./slack_mcp.md)
- [Try the complete Go tools example](../examples/claude-go/README.md)

### Look up behavior

- [CLI reference](./cli_reference.md) — options, defaults, paths, and image selection.

### Understand the design

- [Profiles and containers](./profile_model.md) — which files remain after a session.
- [Security model](./security.md) — agent access to files, credentials, and the host.

### Agent-specific guides

Common tasks use the guides above. These pages cover differences between agents.
Gemini is deprecated in InBox; its guides remain for existing users.

| Agent | Login | Instructions | Add tools | Settings |
| --- | --- | --- | --- | --- |
| Claude | [Sign in](./claude/getting_started.md) | [Instruction file](./claude/using_memory_files.md) | [Dockerfile](./claude/extending_container.md) | [Optional traffic](./claude/optional_settings.md) |
| Codex | [Sign in](./codex/getting_started.md) | [Instruction file](./codex/using_memory_files.md) | [Dockerfile](./codex/extending_container.md) | [Web search](./codex/optional_settings.md) |
| Antigravity | [Sign in](./antigravity/getting_started.md) | [Instruction file](./antigravity/using_memory_files.md) | [Dockerfile](./antigravity/extending_container.md) | [Cloud project](./antigravity/google_cloud_project.md) |
| Gemini (legacy) | [Sign in](./gemini/getting_started.md) | [Instruction file](./gemini/using_memory_files.md) | [Dockerfile](./gemini/extending_container.md) | [Cloud project](./gemini/google_cloud_project.md) |

### For contributors

- [Contribute and add an agent](../CONTRIBUTING.md)
- [Codex login implementation](./codex/login_implementation.md)

[Project README](../README.md)
