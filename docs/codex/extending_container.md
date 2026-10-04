## Add tools to the Codex image

Follow [Build a custom profile image](../custom_images.md) with agent `codex` and profile `work`.
Use this Dockerfile in the profile directory:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-codex
RUN apk add --no-cache go ripgrep
```

Codex's image uses Alpine and `apk`.
Keep the base image's entrypoint. Add the common guide's `.dockerignore` before building to exclude credentials.

After building, check `go version` and `rg --version` using the common guide's verification step.

[Documentation index](../README.md) · [Build and check the image](../custom_images.md)
