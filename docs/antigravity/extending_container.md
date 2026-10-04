## Add tools to the Antigravity image

Follow [Build a custom profile image](../custom_images.md) with agent `antigravity` and profile `work`.
Use this Dockerfile in the profile directory:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-antigravity
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*
```

Antigravity's image uses Debian and `apt-get`.
Keep the base image's entrypoint. Add the common guide's `.dockerignore` before building to exclude credentials.

After building, check `python3 --version` and `pip3 --version` using the common guide's verification step.

[Documentation index](../README.md) · [Build and check the image](../custom_images.md)
