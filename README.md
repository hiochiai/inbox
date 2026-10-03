# InBox — Local Coding Agent Runtime

Run coding agents in disposable Docker containers with persistent, reusable profiles.
Keep work and personal logins, settings, and tools separate—without installing agent dependencies on your host.

[![CI](https://github.com/hiochiai/inbox/actions/workflows/build.yml/badge.svg)](https://github.com/hiochiai/inbox/actions/workflows/build.yml)

- **A home for each identity:** separate agent credentials, configuration, and home-directory state.
- **Throw away the container, keep the profile:** return to your setup on the next run.
- **Your tools, per profile:** extend an agent image with a Dockerfile.
- **One small CLI:** choose the agent, profile, and project; forward the agent's own arguments.
- **Ask another agent:** with Docker access enabled, Claude can launch a Codex container with its own profile for a second opinion. [Handoff recipe](./examples/agent-handoff/README.md).

```bash
# Run from your project directory; exit each session before the next command
inbox claude -p work
inbox claude -p personal   # Separate login and settings
inbox codex -p work       # Separate Codex home; no shared Claude credentials
```

**Runtime defaults:** InBox adds flags that skip agent approval prompts. Your project and profile are writable. Use `-n` to omit those flags; it does not add container hardening. [Security model](./docs/security.md).

## Why InBox?

You can write your own `docker run` wrapper. InBox keeps the recurring parts together: profile homes, image selection, custom image builds, user-ID setup, argument forwarding, and optional host connections.

The useful unit is **agent × profile × environment × project**: choose an agent and profile, use its default or custom image, and mount your current directory. You can reuse the same profile across projects. There is no InBox account, daemon, or cloud service; agents still connect to their providers.

Choose InBox when you want a small, readable tool for managing local AI CLI environments. Agent-native sandboxes and Docker Sandboxes focus on execution boundaries; devcontainers offer broader project and editor configuration. InBox focuses on reusable profiles and a consistent launch command.

## Quick start

You need **Bash, curl, and a running Docker installation with Linux container support**, plus access to your chosen agent provider. No host Node.js installation is needed. Images are built for `linux/amd64` and `linux/arm64`. Linux and macOS are the intended host environments; Windows requires a Bash/Linux environment such as WSL2 and is not covered by host integration tests.

### 1. Install

Download the release script into a user-owned directory; no `sudo` is needed:

```bash
mkdir -p "$HOME/.local/bin" &&
  curl -fL https://github.com/hiochiai/inbox/releases/latest/download/inbox -o "$HOME/.local/bin/inbox" &&
  chmod +x "$HOME/.local/bin/inbox"
export PATH="$HOME/.local/bin:$PATH"
inbox version
```

Keep the `PATH` export in your shell startup file if this directory is not already on your path. This installs executable code from GitHub; you can inspect the downloaded script before `chmod` and execution. [Pinned installation, updates, and removal](./docs/installation.md).

### 2. Run and authenticate

From a project directory you are comfortable letting the agent edit:

```bash
inbox claude -p work -n
```

The first run downloads the image and creates `~/.inbox/claude-work`. Follow Claude's terminal login instructions, opening the displayed URL in your host browser. Credentials saved in the container home persist in this profile. Image download and provider login time vary.

Prefer Codex? Use `inbox codex -p work --sign-in-with-chatgpt` to start **Sign in with ChatGPT** directly, without choosing an authentication method. The command exits after login; then run `inbox codex -p work`. An updated Codex image is required; Docker host networking is unnecessary. [Codex login guide](./docs/codex/getting_started.md).

### 3. Switch identities

Exit the agent, then start a separate profile and sign in with the other account:

```bash
inbox claude -p personal -n
# Later, return to the existing work login and settings
inbox claude -p work -n
```

Once you understand the writable mounts and approval behavior, omitting `-n` uses InBox's autonomous defaults.

## What a profile contains

A profile is a **persistent container home**, scoped to an agent and a name. It holds whatever the agent writes there: credentials, settings, caches, and session state. An optional Dockerfile selects a custom tool environment after an explicit build. It is not a shared identity provider or a separate copy of your project.

```text
Host                                      Disposable container
~/.inbox/claude-work/  ── read-write ──▶   /home/inbox
  credentials, settings, state             Claude Code
current project/      ── read-write ──▶   /workspace
                                           tools from selected image
                     container exits → removed
                     profile + project → remain on host
```

`inbox claude` uses `~/.inbox/claude`; `inbox claude -p work` uses `~/.inbox/claude-work`. `inbox codex -p work` has its own `~/.inbox/codex-work`. Names do not synchronize credentials between agents. Use simple names such as `work`, `personal`, or `customer-a`.

```bash
inbox profile list
inbox profile claude work              # Print the home directory path
inbox profile set-default claude work
inbox                                 # Launch the selected default
```

`set-default` affects bare `inbox`; it does not change what `inbox claude` selects. Tools installed elsewhere in a running container disappear at exit; put repeatable tools in a [custom profile image](./examples/claude-go/README.md).

## Agents

| CLI | InBox command | Status / login guide |
| --- | --- | --- |
| Claude Code | `inbox claude` | [Available](./docs/claude/getting_started.md) |
| Codex CLI | `inbox codex` | [Available](./docs/codex/getting_started.md) |
| Antigravity CLI (`agy`) | `inbox antigravity` | [Available](./docs/antigravity/getting_started.md) |
| Gemini CLI | `inbox gemini` | [Deprecated in InBox](./docs/gemini/getting_started.md); implementation and image build remain |

OpenCode is not currently supported. These are launch integrations; upstream authentication and settings remain agent-specific.

## Let agents use other agent environments

Enable Docker access and an agent can run build/test containers or invoke another InBox agent image. For example, Claude can ask Codex to review the project using a separate Codex profile, then read its output. Each agent can use its own image and tools.

This uses ordinary Docker commands with explicit host paths and non-interactive agent arguments; there is no built-in scheduler or conversation transfer. Docker socket access grants broad authority over the Docker host. See the [Claude → Codex recipe and verification limits](./examples/agent-handoff/README.md).

## Arguments and host integrations

```bash
inbox claude -- --help                    # Agent help
inbox --help                          # InBox help
inbox claude -p work -n -- -p "Explain this project"  # Agent's -p, not InBox's
inbox claude -p work -A                # Forward SSH agent explicitly
inbox claude -p work -D /var/run/docker.sock  # Give access to host Docker
```

Before `--`, only InBox options (`-p`, `-n`, `-A`, `-D` and their long forms) are accepted. All agent arguments must follow `--`; unknown options or positional arguments before it are errors. The first separator is removed; subsequent arguments are forwarded unchanged. `--` alone is allowed and adds no agent arguments. Repeated InBox profile/socket options use the last value. Give option values as separate, non-empty arguments that do not start with `-`; joined forms such as `-pwork`, `--profile=work`, and combined flags such as `-nA` are not supported.

**Breaking change from v0.14.1:** implicit argument forwarding has been removed. Replace `inbox claude --help` with `inbox claude -- --help`, and `inbox codex "Explain this project"` with `inbox codex -- "Explain this project"`. The v0.14.1 release does not support the separator. Use InBox v0.15.0 or newer for this syntax.

Host environment variables are not forwarded automatically. SSH forwarding permits use of loaded keys; Docker socket access can grant control over the Docker host. See [security boundaries](./docs/security.md) and [Docker integration](./docs/docker_outside_of_docker.md).

## Documentation

- [Install, update, troubleshoot, uninstall](./docs/installation.md)
- [Security model](./docs/security.md) · [Default startup](./docs/default_startup.md)
- [Documentation index](./docs/README.md) — start, complete a task, look up behavior, or understand the design
- [First session tutorial](./docs/getting_started.md) · [CLI reference](./docs/cli_reference.md)
- [Manage profiles](./docs/profiles.md) · [Build custom images](./docs/custom_images.md) · [Profile model](./docs/profile_model.md)
- [Custom Go tools example](./examples/claude-go/README.md) · [Claude → Codex handoff](./examples/agent-handoff/README.md)
- [Running images in CI](./docs/running_in_ci.md) · [MCP configuration](./docs/slack_mcp.md)
- [Contributing and adding an agent](./CONTRIBUTING.md)

[MIT licensed](./LICENSE). Found a useful setup? Share the agent, profile use case, and Dockerfile—with credentials removed—in an issue.
