## Security model

InBox runs agents in Docker containers. Agents can edit your project and read the selected profile.
InBox does not provide a hardened sandbox, a network policy, or encrypted credential storage.

### What is separated

By default, InBox mounts only the selected profile and current project.
Other host files are not mounted separately. Files inside either selected directory are accessible to the agent.
Starting InBox from your home directory therefore exposes everything under that directory.

Docker isolation depends on your Docker setup and operating system. It does not guarantee protection against container escapes.
The container is removed at exit; files in the project and profile remain.

### What is exposed

| Resource | Access |
| --- | --- |
| Project at `/workspace` | Read and write, including `.git` and any project secrets |
| Profile at `/home/inbox` | Read and write, including credentials and saved settings |
| Network | Normal Docker networking; InBox does not filter outgoing data |
| Approval prompts | InBox adds flags that skip prompts unless you use `-n` |
| Container user | Startup begins as root, attempts user-ID setup, then runs as `inbox`. Package-manager sudo is allowed. |

See the [CLI reference](./cli_reference.md#launch-an-agent) for each agent's default flag.
Direct ChatGPT login omits these flags automatically.

`-n` only omits InBox's default flag. The agent's settings still control approvals and its own sandbox.
InBox adds no capability restrictions, read-only root filesystem, resource limits, or restricted network.

An agent can read credentials in its profile. Profiles organize accounts; they do not isolate users who distrust each other.
Use trusted images and profile files. The launcher reads `~/.inbox/default.conf` as shell code.

### Optional host connections

| Connection | Additional access |
| --- | --- |
| `-D <socket>` | Host Docker control. An agent can start containers that mount other host paths. |
| `-A` | Use of loaded SSH keys through the SSH agent. Key files are not copied. |
| Custom images and MCP servers | Code you choose can use the project, profile, and enabled connections. |

A Docker daemon running as root can give a socket-connected agent root access to the host.
Remote and rootless Docker have different access limits.

SSH forwarding lets container processes request signatures and authenticate with loaded keys.
The entrypoint tries to change socket ownership. Socket behavior varies by host and Docker installation.

Custom image builds use the profile directory as their build context.
Use a [`.dockerignore`](./custom_images.md#prepare-and-build) to exclude credentials before building.

For experiments, use a separate project copy and profile. InBox does not create project copies automatically.
A Git worktree may share Git metadata; it is not a security boundary.

### Local-first does not mean offline

InBox adds no hosted service or account. Agents and tools can send data to their providers and configured services.
Those services' policies and account permissions still apply.

[Documentation index](./README.md) · [CLI reference](./cli_reference.md)
