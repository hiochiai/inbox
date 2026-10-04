## Quick Start for Codex

Install [InBox](../installation.md) and start Docker. Run these commands in your host terminal.

### Sign in with ChatGPT

1. Start login for the `work` profile:

   ```bash
   inbox codex -p work --sign-in-with-chatgpt
   ```

2. Open the displayed URL in a browser on the Docker host. Complete sign-in.
   Keep the terminal open until login succeeds. The command then exits.

This login command needs no `-n` and accepts no extra agent arguments.
Both the launcher and Codex image must support direct ChatGPT login.

### Start using Codex

From your project directory, run:

```bash
inbox codex -p work -n
```

Your login is saved in `~/.inbox/codex-work/.codex`.
Exit and run the same command to return to your profile.
`-n` omits InBox's default flag that skips approvals; your project remains writable.

### Login problems

- To check your login, run `inbox codex -p work -n -- login status`.
- If port 1455 is occupied, stop the other login listener and retry.
- Refresh both the launcher and image using the [update guide](../installation.md#updates-and-image-versions).
- For a remote Docker daemon, use a callback tunnel or try device code login below.

### Alternative: device code login

```bash
inbox codex -p work -n -- login --device-auth
```

Open the displayed URL and enter the code. This method needs no port forwarding.
Device code login must be enabled in your ChatGPT security settings or by your workspace administrator.

<a id="building-and-callback-forwarding"></a>
For source builds and callback details, see the [login implementation](./login_implementation.md).

[Documentation index](../README.md) · [Manage profiles](../profiles.md) · [Security model](../security.md)
