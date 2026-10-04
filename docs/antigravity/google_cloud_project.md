## Google Cloud project configuration

If your Antigravity version needs `GOOGLE_CLOUD_PROJECT`, set it in a custom image.
Whether the agent uses it depends on its version and login method.

Follow [Build a custom image](../custom_images.md) with agent `antigravity` and profile `work`.
Use this Dockerfile, replacing `your-project-id` with your project ID:

```dockerfile
FROM ghcr.io/hiochiai/inbox:latest-antigravity
ENV GOOGLE_CLOUD_PROJECT=your-project-id
```

After building, start the profile:

```bash
inbox antigravity -p work -n
```

InBox does not forward host environment variables automatically.
Do not put credentials in the Dockerfile.

[Documentation index](../README.md) · [Login guide](./getting_started.md)
