## Ask another agent from an InBox session

Give Claude Docker access so it can ask Codex to review a project.
Codex uses its own profile and returns text output to Claude.

```text
Claude container --> Host Docker service --> Codex container
      ^                                      |
      +------------- review output ----------+
```

### 1. Prepare on the host

1. Sign in to a separate Codex profile, then wait for login to finish:

   ```bash
   inbox codex -p reviewer --sign-in-with-chatgpt
   ```

   If needed, use the [alternative login method](../../docs/codex/getting_started.md#alternative-device-code-login).

2. From your project directory, record its path, the profile path, and the user ID:

   ```bash
   pwd -P
   inbox profile codex reviewer
   id -u
   ```

3. Start Claude with Docker access:

   ```bash
   inbox claude -p work -n -D /var/run/docker.sock
   ```

   Adjust the socket path for your installation. See [Docker setup](../../docs/docker_outside_of_docker.md) if access fails.
   Docker access gives Claude broad control over the host's Docker service.

### 2. Give Claude the explicit Codex command

Replace both host paths and `1000` below with the values recorded above.
Ask Claude to run the command through its shell tool and read the review:

```bash
docker run --rm \
  --mount 'type=bind,src=/absolute/host/project,dst=/workspace,readonly' \
  --mount 'type=bind,src=/absolute/host/.inbox/codex-reviewer,dst=/home/inbox' \
  -e HOST_UID=1000 \
  ghcr.io/hiochiai/inbox:0.14.1-codex \
  exec --sandbox read-only \
  'Review the current project for correctness risks. Report findings; do not edit files.'
```

Use a Git repository for this example. Expect review text and the command's exit status.
The image tag matches the [recorded checks](./verification.md). Image tags can change.
Model execution needs working authentication and provider access; usage charges apply.

The image already starts Codex, so its arguments begin with `exec`, not `codex exec`.
Direct image execution does not add InBox's default flags that skip approvals.
Do not add `-it`: this command runs without an interactive terminal.

### Paths and scope matter

- Use paths on the Docker host, not Claude's `/workspace` or container home.
- Codex gets its own login and settings. It does not receive Claude's conversation. Include needed context in the prompt or project.
- Codex's project mount is read-only. Its profile remains writable and networking remains enabled.
- Tests that write files need a separate writable project copy.
- Stop editing during review if you need stable input. InBox does not create a snapshot.
- Claude's Docker access can reach other host files and profiles. Codex's read-only mount does not restrict Claude.

### Why not just run `inbox codex` inside Claude?

The images include Docker CLI, but not the InBox launcher.
The launcher also expects host project paths and an interactive terminal.
Use the explicit Docker command above.

### Verification scope

Container startup and mount behavior were checked without real credentials or model calls.
Authenticated task completion and macOS/WSL2 compatibility were not tested end to end.
See the [verification record](./verification.md) for versions and checks.

[Documentation index](../../docs/README.md) · [Security model](../../docs/security.md)
