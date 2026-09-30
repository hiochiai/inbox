## Build a custom profile image

Install repeatable tools in an image so they remain available across sessions. You need a running Docker daemon and InBox. Run these steps in your **host terminal**; no agent login is needed to build.

### Prepare and build

1. Choose an agent and named profile. This example uses Claude and `tools`:

   ```bash
   inbox_agent=claude
   inbox_profile=tools
   inbox_profile_dir=$(inbox profile "$inbox_agent" "$inbox_profile")
   mkdir -p "$inbox_profile_dir"
   printf '%s\n' "$inbox_profile_dir"
   ```

2. Create `Dockerfile` in the printed profile directory. For Claude:

   ```dockerfile
   FROM ghcr.io/hiochiai/inbox:latest-claude
   RUN apk add --no-cache go ripgrep
   ```

   Other bases and package managers: [Codex](./codex/extending_container.md), [Antigravity](./antigravity/extending_container.md), [Gemini](./gemini/extending_container.md). Retain the base image's entrypoint.

3. Before building, create or edit `.dockerignore` in the same directory:

   ```text
   **
   !Dockerfile
   !.dockerignore
   ```

   The entire profile home is the build context and may contain credentials. This example sends only the Dockerfile and ignore file. Explicitly allow any other required build inputs; never copy credentials into the image.

4. Build the image using the same agent and profile:

   ```bash
   # Use the standard repository for this example
   unset INBOX_IMAGE
   inbox profile build-image "$inbox_agent" "$inbox_profile"
   ```

   Expect `Build successful.` and a tag ending in `:claude-tools` for the example values.

### Check the tools and launch

Check the tools without an agent login or profile mount:

```bash
# CI enables the image entrypoint's shell-command path
docker run --rm -e CI=true ghcr.io/hiochiai/inbox:claude-tools \
  sh -c 'go version && rg --version'
```

Both commands should print version information. For another agent or profile, change the image tag and tool checks accordingly.

Then change to your project directory and launch:

```bash
inbox claude -p tools -n
```

The launcher prints `Using custom image for profile`. Authenticate if this home has not been used before. Tools come from the image; credentials and settings remain in the mounted home.

Rebuild after editing the Dockerfile. A tagged `INBOX_IMAGE` overrides the custom image; see [image selection](./cli_reference.md#image-selection). Mutable base tags may be cached: pull the base explicitly before rebuilding to refresh it, or use a digest in `FROM` for reproducible builds.

[Documentation index](./README.md) · [Complete Go example](../examples/claude-go/README.md) · [Profile model](./profile_model.md)
