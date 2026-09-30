## Installation and maintenance

### Release installation

Use the [README quick start](../README.md#quick-start) for the latest release. For a specific launcher version, replace its download URL with a release asset such as:

```text
https://github.com/hiochiai/inbox/releases/download/v0.14.1/inbox
```

Downloading a script is a trust decision. Review it before execution if required by your workflow. A `curl | sh` installer is not necessary for this single Bash file and would execute fetched code immediately. The current release workflow publishes the script, without a separate checksum/signature asset.

### From a checkout

```bash
# Run this in your reviewed InBox checkout
mkdir -p "$HOME/.local/bin" && install -m 755 inbox "$HOME/.local/bin/inbox"
export PATH="$HOME/.local/bin:$PATH"
inbox version
```

### Updates and image versions

`inbox update` downloads the launcher from **main**, checks Bash syntax, and replaces the running script. It is not a release-pinned or cryptographically verified update; it requires curl, realpath, and write access to the installed path. To stay on releases, repeat the release installation instead.

The default image is `ghcr.io/hiochiai/inbox:<launcher-version>-<agent>`. CI rebuilds these tags with upstream agent updates; a launcher version does not pin the agent or image contents. Docker can reuse a locally cached image. For the default Claude image, derive the tag from your installed launcher and pull it explicitly:

```bash
inbox_launcher_version=$(inbox version) &&
  docker pull "ghcr.io/hiochiai/inbox:${inbox_launcher_version##* }-claude"
```

Replace `claude` with your chosen agent. This refreshes the default image only; if you use `INBOX_IMAGE`, pull the image selected by that override. For a custom profile image, update its base image as needed and rebuild with `inbox profile build-image <agent> [<profile>]`.

`INBOX_IMAGE` overrides image selection. A value containing `:` is used directly and overrides the profile Dockerfile; otherwise InBox appends a profile or version/agent tag. Use the matching agent image and entrypoint.

### Troubleshooting

- Run `docker info` to check daemon access. Docker permissions are managed by your installation; access to a rootful daemon is powerful.
- First launch needs network access to GHCR and the provider. Image downloads can take more than five minutes on a slow connection.
- Find a profile with `inbox profile claude work`. If login fails, try a fresh named profile rather than deleting existing credentials and state.
- The launcher always requests a TTY (`-it`); for headless CI, use the [container images directly](./running_in_ci.md).
- No ports are published. Browser localhost callbacks and host access to development servers need separate container configuration; the launcher has no port-publishing flag.
- Bind mounts refer to paths on the Docker daemon's host. A remote Docker context is not a transparent local-workspace setup.

### Uninstall

Remove the script from the path where you installed it:

```bash
rm "$HOME/.local/bin/inbox"
```

Profiles in `~/.inbox` and Docker images remain. Back up any needed credentials, settings, and sessions before manually deleting selected profiles. Remove unused images through Docker after reviewing what other containers use.

[Documentation index](./README.md) · [CLI reference](./cli_reference.md)
