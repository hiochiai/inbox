## Extending the Container & Custom Tools

Build a custom image for an InBox profile to keep additional tools installed across sessions.

### Workflow

1. Create and authenticate a profile, then exit Codex:

   ```bash
   # Create a 'work' profile
   inbox codex -p work
   ```

2. Create `~/.inbox/codex-work/Dockerfile` with the following content:

   ```dockerfile
   FROM ghcr.io/hiochiai/inbox:latest-codex

   # Install additional tools in the Alpine-based Codex image
   RUN apk add --no-cache go ripgrep
   ```

   Use the InBox Codex image as the base and retain its entrypoint. For the unnamed profile, place the Dockerfile at `~/.inbox/codex/Dockerfile` instead.

3. Build the custom image:

   ```bash
   # Rebuild whenever you change the Dockerfile
   inbox profile build-image codex work
   ```

4. Start the profile with the custom image:

   ```bash
   inbox codex -p work
   ```

If `INBOX_IMAGE` includes an explicit tag, it takes precedence over the profile's custom image.

### Docker outside of Docker

To let Codex use the host's Docker daemon, provide the host socket path:

```bash
# Start the work profile with Docker access
inbox codex -p work -D /var/run/docker.sock
```

See [Docker outside of Docker](../docker_outside_of_docker.md) for setup details and the implications of granting access to the host daemon.
