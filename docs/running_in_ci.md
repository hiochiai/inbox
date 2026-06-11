## Running in CI (GitLab Runner)

You can run InBox agents headlessly from a CI system such as GitLab CI. In CI, the runner itself creates the container, taking over the role of the `inbox` launcher script. This page explains how the pieces map and how to set it up.

### How it works

The container entrypoint normally forces the agent binary to run. When the `CI` environment variable is set (GitLab Runner sets `CI=true` automatically) and the first argument is an executable command, the entrypoint instead runs that command as the `inbox` user after completing its root-side setup (UID remapping, sudoers, Docker socket permissions). This lets the CI job shell run inside the container, so your job script can invoke the agent itself.

Everything the `inbox` launcher script passes to `docker run` must be provided by the runner instead:

| `inbox` launcher | CI equivalent |
| :--- | :--- |
| `-v ~/.inbox/<profile>:/home/inbox` | Volume mount in the runner configuration |
| `-e HOST_UID=$(id -u)` | `HOST_UID` CI variable (set it to the UID owning the mounted profile) |
| Default agent arguments (e.g. `--dangerously-skip-permissions`) | Pass explicitly in the job script |
| Image selection | `image:` keyword in the job definition |

### GitLab Runner setup

1. Prepare an authenticated profile on the runner host by running the agent interactively once (see Getting Started). The credentials persist in `~/.inbox/<profile>/`.

2. Register a docker-executor runner and mount the profile into `/home/inbox`. In the runner's `config.toml`:

   ```toml
   [runners.docker]
     volumes = ["/home/<runner-user>/.inbox/claude:/home/inbox"]
     pull_policy = "always"
   ```

### Job definition example

```yaml
ai-run:
  image: ghcr.io/hiochiai/inbox:latest-claude
  variables:
    # Must match the UID of the user owning the mounted profile on the host
    HOST_UID: "1000"
  script:
    - claude -p "your prompt" --dangerously-skip-permissions
```

Notes:

- Do not override the image `entrypoint` in the job definition. The entrypoint must run so the container is set up before the job script executes.
- The job script runs as the `inbox` user with `HOME=/home/inbox`, so the agent finds its profile exactly as in interactive use.
