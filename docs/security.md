## Security model

InBox manages local agent environments. It does not implement a hardened sandbox, network policy, or secret vault.

### What is separated

By default, Docker mounts only the selected profile home and the current project directory. Other InBox profile directories and your host home are not mounted separately. Agent dependencies live in the image. The container's writable layer is removed at exit (`--rm`); mounted data is retained.

This is ordinary Docker isolation, dependent on your Docker configuration and kernel/VM boundary. It is not protection against container escapes. If you launch from your home directory or another broad parent directory, everything beneath that project mount becomes accessible, including any other profiles located there.

### What is exposed

| Resource | Default behavior |
| --- | --- |
| Current directory → `/workspace` | Read-write; agents can delete or modify project files, including `.git` and secrets in the project |
| Selected profile → `/home/inbox` | Read-write; credentials and agent state persist on disk, without InBox encryption |
| Network | Normal Docker networking; no InBox egress filter or exfiltration prevention |
| Approval prompts | Bypassed by the flags below unless `-n` is used |
| Container privileges | Entrypoint starts as root, adjusts UID, then uses `gosu inbox`; package-manager sudo is allowed |

| Agent | Flag added by InBox |
| --- | --- |
| Claude / Antigravity | `--dangerously-skip-permissions` |
| Codex | `--dangerously-bypass-approvals-and-sandbox` |
| Gemini | `--yolo` |

`-n` only omits the flag. Agent settings still control approvals and any agent-native sandbox, whose compatibility depends on the image and host. InBox does not add `--cap-drop`, `no-new-privileges`, read-only roots, resource limits, or a restricted network.

A profile separates stored identities for convenience, not hostile tenants. An agent can read credentials in its selected home. Profiles, images, and `~/.inbox/default.conf` must be trusted; the launcher currently sources that default configuration as shell code.

### Optional host connections

- **`-D <socket>`:** exposes the Docker daemon. An agent may create containers mounting host paths, bypassing the launcher's intended mount scope. With a rootful daemon this can amount to host root control; remote/rootless daemon scope differs. Do not treat this as an isolated Docker build service.
- **`-A`:** forwards `SSH_AUTH_SOCK`. Private key files are not copied, but container processes can request signatures and authenticate to systems reachable with those keys. The entrypoint attempts to change socket ownership; host behavior and Docker Desktop socket paths vary.
- **Custom images / MCP servers:** run code you choose with access to the same project, profile, and enabled integrations. Inspect their source. Profile image builds use the profile directory as build context; use a `.dockerignore` that excludes credentials and avoid copying the home into an image.

For experiments, use a disposable project copy and a dedicated profile. A Git worktree limits accidental edits to the working tree but may share Git metadata; it is not a security boundary. InBox does not currently create clones or worktrees automatically.

### Local-first does not mean offline

InBox adds no account or hosted service. Agents and installed tools can send data to their providers and configured external services. Provider policies and account permissions still apply.
