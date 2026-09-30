## InBox documentation

Choose a page by what you want to do. Commands run on the host unless a page explicitly says otherwise.

### Start here

- [Run your first persistent session](./getting_started.md) — install, authenticate, exit, and return to the same profile.
- [Install and maintain InBox](./installation.md) — installation choices, updates, startup problems, and removal.

### Complete a task

- [Create and switch profiles](./profiles.md) — keep work and personal state separate.
- [Set default startup](./default_startup.md) — choose what bare `inbox` launches.
- [Pass agent arguments](./passing_arguments.md) — separate launcher options from agent options.
- [Build a custom image](./custom_images.md) — keep additional tools across sessions.
- [Connect the host Docker daemon](./docker_outside_of_docker.md) — enable Docker access from an agent.
- [Run images in CI](./running_in_ci.md) — invoke agents without the interactive launcher.
- [Configure MCP services](./slack_mcp.md) — configure tools inside an agent profile.
- [Ask Codex from Claude](../examples/agent-handoff/README.md) — a complete Docker-based handoff recipe.
- [Add Go tools to Claude](../examples/claude-go/README.md) — a complete Dockerfile and ignore-file example.

### Look up behavior

- [CLI reference](./cli_reference.md) — commands, options, defaults, paths, and image selection.
- [Agent-specific guides](#agent-specific-guides) — login, memory files, and configuration differences.

### Understand the design

- [Profiles and containers](./profile_model.md) — what persists and how homes, projects, and images relate.
- [Security model](./security.md) — writable mounts, approvals, and host access.

### Agent-specific guides

Start with your agent's login guide, then choose its settings or tools. Gemini is deprecated in InBox; its implementation remains available.

| Agent | Authentication | Persistent instructions | Tools |
| --- | --- | --- | --- |
| Claude | [Login](./claude/getting_started.md) | [Memory](./claude/using_memory_files.md) | [Image](./claude/extending_container.md) |
| Codex | [Login](./codex/getting_started.md) | [Memory](./codex/using_memory_files.md) | [Image](./codex/extending_container.md) |
| Antigravity | [Login](./antigravity/getting_started.md) | [Memory](./antigravity/using_memory_files.md) | [Image](./antigravity/extending_container.md) |
| Gemini | [Login](./gemini/getting_started.md) | [Memory](./gemini/using_memory_files.md) | [Image](./gemini/extending_container.md) |

Additional settings: [Claude](./claude/optional_settings.md), [Codex](./codex/optional_settings.md), Google Cloud project for [Antigravity](./antigravity/google_cloud_project.md) and [Gemini](./gemini/google_cloud_project.md).

[Contributing](../CONTRIBUTING.md)

[Project README](../README.md)
