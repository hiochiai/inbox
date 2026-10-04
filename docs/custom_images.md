## Build a custom profile image

Add tools to an image so they remain available across sessions.
Run these steps in your host terminal with InBox installed and Docker running. No agent login is needed to build.

### Prepare and build

1. Choose an agent and profile. This example uses Claude and `work`:

   ```bash
   inbox_agent=claude
   inbox_profile=work
   inbox_profile_dir=$(inbox profile "$inbox_agent" "$inbox_profile")
   mkdir -p "$inbox_profile_dir"
   printf '%s\n' "$inbox_profile_dir"
   ```

2. Open `Dockerfile` in that directory. Add these lines, or edit an existing Dockerfile to keep your other tools:

   ```dockerfile
   FROM ghcr.io/hiochiai/inbox:latest-claude
   RUN apk add --no-cache go ripgrep
   ```

   Other agents: [Codex](./codex/extending_container.md), [Antigravity](./antigravity/extending_container.md), [Gemini](./gemini/extending_container.md).
   Keep the base image's entrypoint.

3. Create or edit `.dockerignore` in the same directory before building:

   ```text
   **
   !Dockerfile
   !.dockerignore
   ```

   Docker uses the profile directory as its build context. That directory may contain credentials.
   This example excludes everything except the two build files. Allow other files only when the build needs them.
   Never copy credentials into an image.

4. Build using the same agent and profile:

   ```bash
   # Use the standard image repository
   unset INBOX_IMAGE
   inbox profile build-image "$inbox_agent" "$inbox_profile"
   ```

   Expect `Build successful.`. For this example, the image tag ends in `:claude-work`.

### Check the tools and launch

Check the tools without mounting your profile:

```bash
# CI lets the entrypoint run a shell command
docker run --rm -e CI=true "ghcr.io/hiochiai/inbox:${inbox_agent}-${inbox_profile}" \
  sh -c 'go version && rg --version'
```

Both tools should print their versions. For another Dockerfile, replace the checks with its installed tools.
For the Antigravity example, use `python3 --version && pip3 --version`.

From your project directory, start the profile:

```bash
inbox "$inbox_agent" -p "$inbox_profile" -n
```

Expect `Using custom image for profile`. Sign in if this profile has no saved login.
The image supplies tools; the profile saves your login and settings.

### Rebuild

Rebuild after editing the Dockerfile:

```bash
inbox profile build-image "$inbox_agent" "$inbox_profile"
```

To refresh a cached base image, pull the image in your `FROM` line before rebuilding.
Use an image digest in `FROM` when you need the same base contents every time.
A tagged `INBOX_IMAGE` can override your custom image; see [image selection](./cli_reference.md#image-selection).

[Documentation index](./README.md) · [Complete Go example](../examples/claude-go/README.md) · [What persists](./profile_model.md)
