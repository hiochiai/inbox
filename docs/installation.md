## Installation and maintenance

Install the InBox script, then follow the [first session guide](./getting_started.md).
Run these commands in your host terminal: the terminal on your computer, outside the agent.

### Requirements

You need Bash, curl, and Docker running with Linux container support. You do not need Node.js on the host.

Linux and macOS are the intended hosts. On Windows, use a Bash/Linux environment such as WSL2.
Windows host integrations are not covered by the project's tests. Images support `linux/amd64` and `linux/arm64`.

### Release installation

1. Download the latest release:

   ```bash
   mkdir -p "$HOME/.local/bin" &&
     curl -fL https://github.com/hiochiai/inbox/releases/latest/download/inbox -o "$HOME/.local/bin/inbox"
   ```

2. Inspect the downloaded script if needed, then make it executable:

   ```bash
   chmod +x "$HOME/.local/bin/inbox"
   export PATH="$HOME/.local/bin:$PATH"
   inbox version
   ```

   The last command prints the installed version. Add the `PATH` line to your shell startup file to keep it.

No `sudo` is needed. The release workflow publishes the script without a separate checksum or signature file.
For a specific version, copy the asset URL from that version's [GitHub release](https://github.com/hiochiai/inbox/releases).
The argument examples in these guides require v0.15.0 or newer. Direct ChatGPT login requires a launcher and Codex image with that feature.

### From a checkout

Run this in your InBox repository checkout:

```bash
mkdir -p "$HOME/.local/bin" && install -m 755 inbox "$HOME/.local/bin/inbox"
export PATH="$HOME/.local/bin:$PATH"
inbox version
```

### Updates and image versions

To update to a release, repeat the release installation above.
`inbox update` instead downloads from **main**, checks Bash syntax, and replaces the installed script.
It requires curl, realpath, and write access to that script. It does not verify a signature.

Updating the script does not refresh cached images. To refresh the default Claude image:

```bash
inbox_launcher_version=$(inbox version) &&
  docker pull "ghcr.io/hiochiai/inbox:${inbox_launcher_version##* }-claude"
```

Replace `claude` with your agent. Image tags can change when CI rebuilds them, even for the same launcher version.
For a custom image, pull its base and [rebuild](./custom_images.md#rebuild).
For `INBOX_IMAGE`, pull the image selected by your override. See [image selection](./cli_reference.md#image-selection).

### Troubleshooting

| Problem | What to check |
| --- | --- |
| Docker connection fails | Run `docker info`. Check that Docker is running and your user has access. |
| First launch is slow | Image downloads need network access and can take several minutes. |
| Login fails | Follow your agent's [login guide](./README.md#agent-specific-guides). Try a fresh named profile before deleting saved settings. |
| A CI job reports a terminal error | The launcher requires a terminal. Use [images directly in CI](./running_in_ci.md). |
| A browser callback fails | Use [direct ChatGPT login](./codex/getting_started.md) for Codex. Other callbacks may need separate container configuration. |
| Codex login port is occupied | Stop the other listener on host port 1455, then retry. |
| A development server is unreachable | Normal sessions publish no ports. The launcher has no general port-publishing option. |
| Files are missing with remote Docker | Mounted paths belong to the Docker daemon's host, not your local computer. |

Direct ChatGPT login is the port exception: it publishes a local callback port while signing in.
Both the launcher and Codex image must support it; see [login implementation](./codex/login_implementation.md).

### Uninstall

Remove the script from its installed location:

```bash
rm "$HOME/.local/bin/inbox"
```

Profiles in `~/.inbox` and Docker images remain. Back up needed files before deleting profiles.
Review image usage in Docker before removing images.

[Documentation index](./README.md) · [CLI reference](./cli_reference.md)
