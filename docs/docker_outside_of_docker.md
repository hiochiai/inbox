## Docker outside of Docker (DooD)

Let an agent build images and run containers through your host's Docker service.
This gives the agent broad control over Docker on the host.

### Usage

From your project directory, run:

```bash
inbox claude -p work -n -D /var/run/docker.sock
```

Replace the socket path if your Docker installation uses a different one.
Without `-D`, InBox does not connect the host Docker socket.

### Verifying Docker Access

Ask the agent to run:

```bash
docker ps
```

Expect a list of running containers on the host. If access fails, check the socket path and permissions.

### How It Works

The image includes the Docker CLI. `-D` mounts the host socket at `/var/run/docker.sock` inside the container.
The entrypoint tries to add the agent user to the socket's group. That group must exist in the image.
Rootless Docker and Docker Desktop may need extra configuration.

### Calling another coding agent

An agent with Docker access can start another InBox image and read its output.
See [Ask Codex from Claude](../examples/agent-handoff/README.md) for the commands and host paths.

### Security Considerations

Socket access lets an agent create and stop containers, mount host files, and access Docker volumes and networks.
With a Docker daemon running as root, this can give the agent root access to the host.

`-n` only changes approval defaults. It does not restrict Docker access.
See the [security model](./security.md#optional-host-connections).

[Documentation index](./README.md) · [CLI reference](./cli_reference.md)
