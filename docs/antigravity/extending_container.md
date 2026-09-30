## Extending the Antigravity Container

You can extend the Antigravity container by creating a `Dockerfile` in your profile directory.

### 1. Identify Profile Directory

```bash
inbox profile antigravity
# Output: /home/user/.inbox/antigravity
```

### 2. Create Dockerfile

Create the directory printed above if needed, then place a `Dockerfile` there:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-antigravity

RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*
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

### Keep credentials out of builds

The build context is the entire profile home. Add a `.dockerignore` before building; exclude everything except required build inputs. Never `COPY` agent credentials into an image. See the [minimal example](../../examples/claude-go/README.md) for a Dockerfile and matching ignore file.
