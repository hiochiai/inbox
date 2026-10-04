# InBox — Local Coding Agent Runtime

Run coding agents in Docker containers. Keep separate logins, settings, and tools for work and personal use.

[![CI](https://github.com/hiochiai/inbox/actions/workflows/build.yml/badge.svg)](https://github.com/hiochiai/inbox/actions/workflows/build.yml)

## Why InBox?

- Run agents without installing their dependencies on your computer.
- Save logins and settings in named profiles.
- Add tools with a profile Dockerfile.

A profile stores an agent's login and settings. These files remain after the container exits. Your project files also remain.

## Quick start

### 1. Install

You need Bash, curl, Docker running with Linux container support, and an account for your chosen agent.
Follow the [installation steps](./docs/installation.md#release-installation), then return here.

### 2. Run and authenticate

Run this command from your project directory:

```bash
inbox claude -p work -n
```

Follow the terminal login instructions. For another agent, use its guide below.

Your agent can edit the project and read the selected profile. InBox normally skips agent approval prompts.
`-n` omits that default; the agent's settings still control approvals. See the [security model](./docs/security.md).

### 3. Switch identities

Exit the session, then use a separate profile:

```bash
inbox claude -p personal -n
```

To return to your saved work login, exit and run `inbox claude -p work -n` again.

## Agents

| Agent | Login guide |
| --- | --- |
| Claude Code | [Start Claude](./docs/claude/getting_started.md) |
| Codex CLI | [Start Codex](./docs/codex/getting_started.md) |
| Antigravity CLI | [Start Antigravity](./docs/antigravity/getting_started.md) |
| Gemini CLI | [Legacy guide](./docs/gemini/getting_started.md) — deprecated in InBox |

## Documentation

<!-- Keep links to former README sections working. -->
<a id="what-a-profile-contains"></a>
<a id="let-agents-use-other-agent-environments"></a>
<a id="arguments-and-host-integrations"></a>

- [Run your first session](./docs/getting_started.md)
- [Create and switch profiles](./docs/profiles.md)
- [Set default startup](./docs/default_startup.md)
- [Pass agent arguments](./docs/passing_arguments.md)
- [Add tools with a custom image](./docs/custom_images.md)
- [Let an agent use Docker](./docs/docker_outside_of_docker.md)
- [Ask Codex from Claude](./examples/agent-handoff/README.md)
- [All documentation](./docs/README.md) · [CLI reference](./docs/cli_reference.md)
- [Contribute](./CONTRIBUTING.md)

[MIT license](./LICENSE)
