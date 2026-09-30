## Add tools to the antigravity image

Follow [build a custom profile image](../custom_images.md), setting `inbox_agent=antigravity` and choosing a named profile. Create the Dockerfile below in that profile home.

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-antigravity
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*
```

This image uses Debian and apt-get. Preserve the base entrypoint. Create the restrictive `.dockerignore` from the common guide **before** building.

For the common guide's `tools` profile, check the result from your **host terminal**:

```bash
docker run --rm -e CI=true ghcr.io/hiochiai/inbox:antigravity-tools \
  sh -c 'python3 --version && pip3 --version'
```

Expect version information for both tools. Then launch from your project directory:

```bash
inbox antigravity -p tools -n
```

The launcher should report that it is using the custom image. Authentication and agent operation require provider access.

[Documentation index](../README.md) · [Build and rebuild procedure](../custom_images.md)
