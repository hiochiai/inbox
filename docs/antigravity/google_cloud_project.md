## Google Cloud project configuration

InBox does **not** automatically forward host environment variables. Prefixing `inbox antigravity` with `GOOGLE_CLOUD_PROJECT=...` does not set that variable inside the container.

If your installed agent version needs this variable, set it in a [custom profile image](./extending_container.md):

```dockerfile
FROM ghcr.io/hiochiai/inbox:0.14.1-antigravity
ENV GOOGLE_CLOUD_PROJECT=your-project-id
```

Build with `inbox profile build-image antigravity work`, then run `inbox antigravity -p work`. Whether this variable is used depends on the agent version and authentication mode. Do not bake credentials into the image.


[Documentation index](../README.md) · [Manage profiles](../profiles.md)
