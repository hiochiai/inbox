## Quick Start for Codex

### Sign in with ChatGPT

Run this command in your host terminal:

```bash
inbox codex -p work --sign-in-with-chatgpt
```

This starts ChatGPT browser login directly, without the authentication-method menu. Open the URL printed by Codex in your browser and complete sign-in. Keep the terminal open until Codex confirms success; the command then exits.

`--sign-in-with-chatgpt` is a Codex-only InBox option. It runs `codex login` and automatically omits the normal approval-bypass arguments, so `-n` is unnecessary. Do not append `-- login`, a prompt, or other agent arguments: they are rejected for this dedicated login action.

No Docker Desktop host-networking setting or device-code permission is needed. Use a browser on the Docker host; a remote Docker daemon needs a separate tunnel. Only one login can use host port 1455 at a time. If Docker reports that this port is occupied, stop the other login listener and retry.

### Start using Codex

Use the same profile to check your login or start a session:

```bash
inbox codex -p work -n -- login status
inbox codex -p work
```

Credentials saved under `/home/inbox/.codex` persist in `~/.inbox/codex-work/.codex` on the host. Use `--sign-in-with-chatgpt` again only when you need to sign in again. Omit `-p work` from all commands if you prefer the unnamed Codex profile.

### Alternative: device code login

```bash
inbox codex -p work -n -- login --device-auth
```

Open the displayed URL and enter the one-time code. This method needs device code login enabled in your ChatGPT security settings or by your workspace administrator, but needs no port forwarding.

### Building and callback forwarding

The launcher and Codex image must both include this feature. Updating the launcher alone is insufficient. To try a local source build, run from the repository root:

```bash
docker build -t inbox-codex:sign-in-with-chatgpt boxes/codex
INBOX_IMAGE=inbox-codex:sign-in-with-chatgpt ./inbox codex -p work --sign-in-with-chatgpt
```

The login command publishes host `127.0.0.1:1455` to container port `61455`. A Node.js TCP relay forwards requests from `0.0.0.0:61455` to Codex at `127.0.0.1:1455` in the same container. It starts before Codex and exits with it; normal sessions do not start the relay or publish the port.

Container port `61455` belongs to IANA's [Dynamic/Private range (49152–65535)](https://www.iana.org/assignments/service-names-port-numbers/), whose ports are not assigned to registered services. This avoids using a registered service port for the relay, but does not guarantee that another process cannot use it. Host port `1455` and Codex's listener remain unchanged to match the browser callback URL.

[Documentation index](../README.md) · [Manage profiles](../profiles.md)
