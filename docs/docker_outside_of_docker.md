## Docker outside of Docker (DooD)

InBox containers can access the host's Docker daemon by mounting the Docker socket. This is known as **Docker outside of Docker (DooD)** and allows AI agents running inside the container to build images, run containers, and use other Docker commands.

### How It Works

When the `-D` (or `--docker-socket`) option is specified, InBox mounts the host's Docker socket into the container. The container image includes the Docker CLI, and the entrypoint script attempts to add the agent user to the socket’s group. The group must exist inside the image; rootless Docker and Docker Desktop setups may require additional configuration.

### Usage

```bash
# Run Claude with Docker socket access
inbox claude -D /var/run/docker.sock

# Run Gemini with Docker socket access
inbox gemini -D /var/run/docker.sock

# Combine with other options
inbox claude -p work -D /var/run/docker.sock
```

The `-D` option requires the path to the Docker socket on the host. The most common path is `/var/run/docker.sock`.

If the option is omitted, Docker socket mounting is disabled and the container runs without access to the host's Docker daemon.

### Verifying Docker Access

Once inside the container, you can verify that Docker is accessible by asking the agent to run:

```bash
docker ps
```

If configured correctly, this will show the running containers on the host.

### Calling another coding agent

The same socket lets an agent launch another InBox image on the host daemon. Claude can invoke Codex non-interactively, give it a separate profile and a read-only project mount, and use its output as a second opinion. The containers are siblings; their homes, images, and arguments are chosen independently.

Follow the [Claude → Codex recipe](../examples/agent-handoff/README.md). It explains host-path mapping, authentication, non-interactive invocation, and what was verified. The images do not include the InBox launcher, so this is an explicit Docker command rather than recursive `inbox` execution.

### Security Considerations

Mounting the Docker socket gives the container **full control over the host's Docker daemon**. This means the agent can:

- Start and stop any container on the host
- Pull and build images
- Access volumes and networks

Only use this option when you trust the agent's actions and understand the implications. The `--no-defaults` (`-n`) flag can be used alongside `-D` to disable the agent's autonomous mode, leaving approval behavior to the agent configuration. It does not restrict daemon access. With a rootful daemon, creating containers with host mounts can grant host root control. See the [security model](./security.md).
