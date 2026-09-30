## InBox command reference

Use this page to look up launcher syntax, defaults, paths, and image selection. Commands run in your **host terminal** unless stated otherwise.

### Launch an agent

```text
inbox <agent> [-p <profile>] [-n] [-A] [-D <socket>] [-- agent_args...]
```

Agents: `claude`, `codex`, `antigravity`, and `gemini` (deprecated in InBox).

| Option | Default | Behavior |
| --- | --- | --- |
| `-p`, `--profile <name>` | Unnamed profile | Select the agent's persistent home |
| `-n`, `--no-defaults` | Disabled | Omit InBox's agent approval-bypass flag |
| `-A`, `--ssh-agent` | Disabled | Mount `SSH_AUTH_SOCK` when set; otherwise warn |
| `-D`, `--docker-socket <path>` | No socket mount | Mount at `/var/run/docker.sock`; warn but continue if the source is not a socket |
| `--` | No forwarded arguments | Forward all following arguments unchanged |

Before `--`, unknown options and positional arguments are errors. Values must be separate, non-empty arguments that do not begin with `-`. Joined options such as `--profile=work` and combined flags such as `-nA` are unsupported. Repeated profile/socket options use the last value. The first separator is removed; subsequent separators and empty arguments are preserved.

```bash
# Host terminal: select an InBox profile and request the agent's own help
inbox claude -p work -n -- --help
```

| Agent | Flag added unless `-n` is present |
| --- | --- |
| Claude, Antigravity | `--dangerously-skip-permissions` |
| Codex | `--dangerously-bypass-approvals-and-sandbox` |
| Gemini | `--yolo` |

Defaults precede forwarded arguments. `-n` leaves approval and sandbox behavior to the agent's own configuration; it adds no container hardening.

### Manage profiles and the launcher

| Command | Result |
| --- | --- |
| `inbox` | Launch the configured default with default flags; without a default, print usage and exit with status 1 |
| `inbox --help` or `inbox -h` | Show launcher help |
| `inbox version` | Print `inbox version <version>` |
| `inbox update` | Replace the installed launcher from GitHub main after a Bash syntax check |
| `inbox profile --help` | Show profile commands |
| `inbox profile list` | List existing agent profile directories |
| `inbox profile default` | Show the configured default agent and profile |
| `inbox profile set-default <agent> [<profile>]` | Set the default for bare `inbox`; does not create the profile home |
| `inbox profile <agent> [<profile>]` | Print a path without creating it; omitted profile inherits the configured default profile name |
| `inbox profile` | Print the configured default's path; fail if no default agent is set |
| `inbox profile build-image <agent> [<profile>]` | Build using the profile home as context; omitted profile means unnamed |

**Profile omission differs by command.** `inbox claude` and `build-image claude` use the unnamed profile even after `set-default claude work`. However, `inbox profile claude` then prints the `claude-work` path. Use explicit profile names when composing commands. See [manage profiles](./profiles.md).

### Paths and container behavior

| Host path | Container path / purpose |
| --- | --- |
| `$HOME/.inbox/<agent>` | `/home/inbox` for an unnamed profile |
| `$HOME/.inbox/<agent>-<profile>` | `/home/inbox` for a named profile |
| Current working directory | `/workspace` |
| `$HOME/.inbox/default.conf` | Default selection, read by the host launcher as shell code |
| `<profile-home>/Dockerfile` | Custom image build definition |

Project and home mounts are writable. Launching creates the profile directory, uses `docker run -it --rm`, and passes `HOST_UID=$(id -u)`. It does not publish ports or automatically forward other host environment variables. The entrypoint attempts UID setup and runs the agent through `gosu inbox`. See [security boundaries](./security.md) and [CI execution](./running_in_ci.md).

### Image selection

The default repository is `ghcr.io/hiochiai/inbox`; `INBOX_IMAGE` overrides it.

| Priority | Condition | Selected image |
| --- | --- | --- |
| 1 | `INBOX_IMAGE` contains `:` | Use its full value directly, including ahead of a profile Dockerfile |
| 2 | Profile Dockerfile exists | `<repository>:<agent>[-<profile>]`; fail if that image is not built locally |
| 3 | Otherwise | `<repository>:<launcher-version>-<agent>` |

The colon check is literal: a registry port also triggers priority 1. For `build-image`, the launcher always appends `:<agent>[-<profile>]`; use an untagged repository without a port or unset `INBOX_IMAGE` when following the standard build guide.

Docker may reuse cached images. See [image updates](./installation.md#updates-and-image-versions).

### Argument migration

InBox v0.15.0 introduced the required separator. With v0.15.0 or newer, replace `inbox claude --help` with `inbox claude -- --help`. v0.14.1 used implicit forwarding and did not support this separator.

[Documentation index](./README.md) · [Pass agent arguments](./passing_arguments.md)
