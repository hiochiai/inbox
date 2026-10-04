## Add tools to the Claude image

Follow [Build a custom profile image](../custom_images.md) with agent `claude` and profile `work`.
Use this Dockerfile in the profile directory:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-claude
RUN apk add --no-cache go ripgrep
```

Claude's image uses Alpine and `apk`.
Keep the base image's entrypoint. Add the common guide's `.dockerignore` before building to exclude credentials.

After building, check `go version` and `rg --version` using the common guide's verification step.

[Documentation index](../README.md) · [Build and check the image](../custom_images.md)
