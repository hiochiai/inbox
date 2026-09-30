## A Claude profile with Go tools

From this repository checkout, prepare a dedicated profile without launching the agent:

```bash
mkdir -p "$HOME/.inbox/claude-go"
cp examples/claude-go/Dockerfile examples/claude-go/.dockerignore "$HOME/.inbox/claude-go/"
inbox profile build-image claude go
```

Then change to your Go project and run:

```bash
inbox claude -p go -n
```

Authenticate on first use. Ask the agent to run `go version` and `rg --version`. Exit and start the same profile again: tools come from the custom image, while home-directory credentials and state come from the profile.

Rebuild after changing the Dockerfile. The base tag can change; use an image digest in `FROM` when you need reproducibility. An explicitly tagged `INBOX_IMAGE` takes precedence over this custom image. Keep `.dockerignore`: the profile is the Docker build context and may contain credentials.
