## Add tools to the claude image

Follow [build a custom profile image](../custom_images.md), setting `inbox_agent=claude` and choosing a named profile. Create the Dockerfile below in that profile home.

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-claude
RUN apk add --no-cache go ripgrep
```

This image uses Alpine and apk. Preserve the base entrypoint. Create the restrictive `.dockerignore` from the common guide **before** building.

For the common guide's `tools` profile, check the result from your **host terminal**:

```bash
docker run --rm -e CI=true ghcr.io/hiochiai/inbox:claude-tools \
  sh -c 'go version && rg --version'
```

Expect version information for both tools. Then launch from your project directory:

```bash
inbox claude -p tools -n
```

The launcher should report that it is using the custom image. Authentication and agent operation require provider access.

[Documentation index](../README.md) · [Build and rebuild procedure](../custom_images.md)
