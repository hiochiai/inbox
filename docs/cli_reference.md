## InBox command reference

Look up options, defaults, paths, and image selection here.
Run commands in your host terminal unless stated otherwise.

### Launch an agent

```text
inbox <agent> [-p <profile>] [-n] [-A] [-D <socket>] [--sign-in-with-chatgpt] [-- agent_args...]
```

Agents: `claude`, `codex`, `antigravity`, and `gemini` (deprecated in InBox).

| Option | Default | Behavior |
| --- | --- | --- |
| `-p`, `--profile <name>` | Unnamed profile | Select a profile for this agent |
| `-n`, `--no-defaults` | Off | Omit the default flag that skips agent approvals |
| `-A`, `--ssh-agent` | Off | Forward `SSH_AUTH_SOCK`; warn if unset |
| `-D`, `--docker-socket <path>` | No socket | Mount at `/var/run/docker.sock`; warn but continue if the source is not a socket |
| `--sign-in-with-chatgpt` | Off | Codex only: sign in through a browser, then exit |
| `--` | No agent arguments | Pass the following arguments unchanged to the agent |

```bash
# Show Claude's help using the work profile
inbox claude -p work -n -- --help
```

Argument rules:

- Put InBox options before `--` and agent arguments after it.
- Unknown options and positional arguments before `--` are errors.
- Give option values as separate, non-empty arguments. Values cannot start with `-`.
- Joined forms such as `--profile=work` and combined flags such as `-nA` are unsupported.
- Repeated profile or socket options use the last value.
- InBox removes the first `--`. Later separators and empty arguments are preserved.
- `--` alone is allowed and adds no agent arguments.

| Agent | Default flag, omitted with `-n` |
| --- | --- |
| Claude, Antigravity | `--dangerously-skip-permissions` |
| Codex | `--dangerously-bypass-approvals-and-sandbox` |
| Gemini | `--yolo` |

Default flags come before agent arguments. With `-n`, the agent's settings control approvals and its own sandbox.
`-n` adds no Docker restrictions. See the [security model](./security.md).

### Codex browser login

```bash
inbox codex -p work --sign-in-with-chatgpt
```

This action runs `codex login` and exits after login. It omits default approval flags, even without `-n`.
Other agents reject this option. Extra arguments after `--` are rejected; an empty separator is allowed.

The login action publishes host `127.0.0.1:1455` to container port `61455`.
Normal sessions publish no ports. Both the launcher and Codex image must support the feature.
See the [login guide](./codex/getting_started.md) or [implementation details](./codex/login_implementation.md).

### Manage profiles and the launcher

| Command | Result |
| --- | --- |
| `inbox` | Launch the saved default with default flags. Without a default, show usage and exit with status 1. |
| `inbox --help` or `inbox -h` | Show InBox help |
| `inbox version` | Print `inbox version <version>` |
| `inbox update` | Replace the installed script from GitHub main after a Bash syntax check |
| `inbox profile --help` | Show profile commands |
| `inbox profile list` | List existing profile directories |
| `inbox profile default` | Show the saved default agent and profile |
| `inbox profile set-default <agent> [<profile>]` | Save the selection for `inbox` with no arguments. Do not create the directory. |
| `inbox profile <agent> [<profile>]` | Print a path without creating it. An omitted name uses the saved default profile name. |
| `inbox profile` | Print the saved default's path. Fail if no default agent is set. |
| `inbox profile build-image <agent> [<profile>]` | Build from the profile directory. An omitted name selects the unnamed profile. |

**An unnamed profile and a default profile are different.**
After `inbox profile set-default claude work`, these commands behave as follows:

| Command | Selected profile |
| --- | --- |
| `inbox` | Claude `work` |
| `inbox claude` | Unnamed Claude profile |
| `inbox profile claude` | Claude `work` path |
| `inbox profile codex` | Codex `work` path, using the saved name even for another agent |
| `inbox profile build-image claude` | Unnamed Claude profile |

Supply both agent and profile names when locating a named profile.
Use `$HOME/.inbox/claude` directly to locate the unnamed Claude profile.

### Paths and container behavior

| Host path | Container path or purpose |
| --- | --- |
| `$HOME/.inbox/<agent>` | `/home/inbox` for an unnamed profile |
| `$HOME/.inbox/<agent>-<profile>` | `/home/inbox` for a named profile |
| Current directory | `/workspace` |
| `$HOME/.inbox/default.conf` | Default selection; the launcher reads this as shell code |
| `<profile-directory>/Dockerfile` | Custom image definition |

Launching creates the profile directory and runs `docker run -it --rm`.
Both project and profile mounts are writable. InBox passes the host user's ID through `HOST_UID`.
The entrypoint attempts to match that ID, then runs the agent through `gosu inbox`.

Host environment variables are not forwarded automatically.
`-A` forwards the SSH socket variable; direct ChatGPT login sets its own relay variable.
Only the [Codex login action](#codex-browser-login) publishes a port.
For execution without a terminal, see [CI usage](./running_in_ci.md).

### Image selection

The default repository is `ghcr.io/hiochiai/inbox`. `INBOX_IMAGE` overrides it.

| Priority | Condition | Selected image |
| --- | --- | --- |
| 1 | `INBOX_IMAGE` contains `:` | Use the full value, even if a profile Dockerfile exists |
| 2 | Profile Dockerfile exists | `<repository>:<agent>[-<profile>]`; fail if it is not built locally |
| 3 | Otherwise | `<repository>:<launcher-version>-<agent>` |

The colon check also matches registry ports.
For `build-image`, InBox always appends `:<agent>[-<profile>]`.
Use a repository without a tag or port, or unset `INBOX_IMAGE` before building.

Docker may reuse cached images. See [image updates](./installation.md#updates-and-image-versions).

### Argument migration

InBox v0.15.0 requires `--` before agent arguments. v0.14.1 used implicit forwarding and did not support this separator.

| Old command | v0.15.0 or newer |
| --- | --- |
| `inbox claude --help` | `inbox claude -- --help` |
| `inbox codex "Explain this project"` | `inbox codex -- "Explain this project"` |

[Documentation index](./README.md) · [Pass agent arguments](./passing_arguments.md)
