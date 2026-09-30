## Ask another agent from an InBox session

With Docker socket access enabled, an agent can launch other containers—including another InBox agent image—and read their command output. For example, Claude can implement a change and ask Codex for a second opinion using Codex's own profile and tool environment.

This is composition through Docker commands, not an InBox orchestration service. The containers are **siblings on the same Docker daemon**, not containers nested inside each other.

```text
Claude container ── Docker socket ──▶ Host Docker daemon
                                           │ starts
                                           ▼
                                     Codex container
                                       /workspace ← project (read-only here)
                                       /home/inbox ← Codex review profile
Claude receives ◀──── stdout / exit status
```

### 1. Prepare on the host

From the project directory, authenticate a dedicated Codex profile, then exit:

```bash
inbox codex -p reviewer -n
```

Use the device-code login flow in the [Codex guide](../../docs/codex/getting_started.md). Record these values on the host for the command in step 2:

```bash
pwd -P                       # Absolute project path on the Docker host
inbox profile codex reviewer # Absolute profile path
id -u                        # UID owning the project/profile
```

Start Claude with Docker access (adjust the socket path for your installation):

```bash
inbox claude -p work -n -D /var/run/docker.sock
```

The socket must be accessible to the in-container user. See [DooD setup](../../docs/docker_outside_of_docker.md). `-n` leaves approval decisions to Claude's configuration; approve the intended Docker command when prompted.

### 2. Give Claude the explicit Codex command

Replace the two example paths and UID below with the host values recorded above. Ask Claude to run the command through its shell tool and consider Codex's output:

```bash
docker run --rm \
  --mount 'type=bind,src=/absolute/host/project,dst=/workspace,readonly' \
  --mount 'type=bind,src=/absolute/host/.inbox/codex-reviewer,dst=/home/inbox' \
  -e HOST_UID=1000 \
  ghcr.io/hiochiai/inbox:0.14.1-codex \
  exec --sandbox read-only \
  'Review the current project for correctness risks. Report findings; do not edit files.'
```

Use a Git repository for this example. `codex exec` is the non-interactive entry point; do not allocate `-it` when invoking it from an agent shell tool. Docker attaches to its output and returns the command's exit status. Successful model execution requires working provider authentication/access and incurs the provider's normal usage costs. Upstream settings and container sandbox compatibility still apply.

The image entrypoint already invokes Codex, so pass `exec ...`, not `codex exec ...`. Direct image execution does **not** add the launcher's default bypass flags. A custom Codex image can be substituted when the reviewer needs additional tools.

### Paths and scope matter

- Mount sources are paths on the **Docker daemon host**, not inside Claude's container. Do not substitute Claude's `/workspace` or `$HOME` for the host paths. This follows [Docker bind-mount semantics](https://docs.docker.com/engine/storage/bind-mounts/).
- Host shell variables are not automatically forwarded by InBox. The explicit command above avoids relying on them. `--mount` fails if a source path is missing instead of silently creating a new directory.
- Codex uses its own profile; it does not inherit Claude credentials, conversation, flags, environment variables, or custom image. Include the needed task/context in the prompt or project files.
- The example gives Codex a read-only project and does not forward Docker or SSH sockets to it. Its profile remains writable and networking remains enabled. Tests needing workspace writes will need a separate writable project copy or a deliberately different mount policy.
- Stop editing while a second agent reviews the shared directory if you need a stable review snapshot. This setup provides neither snapshotting nor concurrent-edit coordination.
- A socket-enabled parent can access other host profiles through the Docker daemon. Separate profiles organize agent state; they do not protect the reviewer credentials from that parent. Child mount restrictions do not constrain the parent.

### Why not just run `inbox codex` inside Claude?

The standard images include Docker CLI, but do not install the `inbox` launcher. Copying it in alone is insufficient: its home/project paths would be resolved from the parent container, while the daemon resolves mount sources on the host, and the launcher always allocates a TTY. Use the explicit image command above until a dedicated handoff UX is designed.

### Verification scope

On 2026-09-29, with Docker 29.8.0 on linux/arm64 and the `0.14.1-claude` / `0.14.1-codex` images, a non-root process in the Claude image successfully started the Codex image through the host socket and ran `codex --version` (0.159.0). Disposable named volumes verified shared project access, rejection of child project writes, retained child home state across runs, and absence of a child Docker socket. The current image's `codex exec --help` confirmed the non-interactive command and sandbox flag.

These checks used no real credentials and made no model calls. Authenticated Claude-to-Codex task completion, the bind-path recipe on a user's host, and macOS/WSL2 socket compatibility were not end-to-end tested. Image tags may move; this is a recorded smoke test, not a compatibility guarantee.
