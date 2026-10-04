## Add tools to the Gemini image

Gemini is deprecated in InBox. These examples are for existing users.

Follow [Build a custom profile image](../custom_images.md) with agent `gemini` and profile `work`.
Use this Dockerfile in the profile directory:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-gemini
RUN apk add --no-cache go ripgrep
```

Gemini's image uses Alpine and `apk`.
Keep the base image's entrypoint. Add the common guide's `.dockerignore` before building to exclude credentials.

After building, check `go version` and `rg --version` using the common guide's verification step.

[Documentation index](../README.md) · [Build and check the image](../custom_images.md)
