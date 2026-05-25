## Extending the Antigravity Container

You can extend the Antigravity container by creating a `Dockerfile` in your profile directory.

### 1. Identify Profile Directory

```bash
inbox profile antigravity
# Output: /home/user/.inbox/antigravity
```

### 2. Create Dockerfile

In that directory, create a `Dockerfile`:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-antigravity

RUN sudo apk add --no-cache python3 py3-pip
```

### 3. Build the Image

```bash
inbox profile build-image antigravity
```

### 4. Run

```bash
inbox antigravity
```

The container will now include the additional tools you installed.
