## A Claude profile with Go tools

Build a dedicated `go` profile from the example files in this repository.
Run the commands in your host terminal with Docker running.

1. From the repository root, copy the example into a new profile directory:

   ```bash
   # Stop if the destination already exists, so existing files are kept
   mkdir -p "$HOME/.inbox" &&
     mkdir "$HOME/.inbox/claude-go" &&
     cp examples/claude-go/Dockerfile examples/claude-go/.dockerignore "$HOME/.inbox/claude-go/"
   ```

   If the profile exists, compare and edit its files instead of replacing them.

2. Build the image:

   ```bash
   unset INBOX_IMAGE
   inbox profile build-image claude go
   ```

3. Change to your Go project and start the profile:

   ```bash
   inbox claude -p go -n
   ```

   Sign in if needed. Ask the agent to run `go version` and `rg --version`.
   Both commands should print version information.

The tools remain available on later runs. Rebuild after changing the Dockerfile.
Keep `.dockerignore` to exclude profile credentials from the build.
See [custom images](../../docs/custom_images.md) for updates and image overrides.
