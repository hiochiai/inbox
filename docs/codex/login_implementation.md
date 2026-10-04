## Codex login implementation

This page is for contributors debugging or building direct ChatGPT login.
For normal use, follow the [login guide](./getting_started.md).

### Build from source

Both the launcher and Codex image must include the login feature.
From the repository root, run:

```bash
docker build -t inbox-codex:sign-in-with-chatgpt boxes/codex
INBOX_IMAGE=inbox-codex:sign-in-with-chatgpt ./inbox codex -p work --sign-in-with-chatgpt
```

### Callback forwarding

The launcher runs `codex login` without its normal flags that skip approvals.
It sets `INBOX_SIGN_IN_WITH_CHATGPT=1` and publishes host `127.0.0.1:1455` to container port `61455`.

A Node.js TCP relay forwards requests from container `0.0.0.0:61455` to Codex at `127.0.0.1:1455`.
The relay starts before Codex and exits with it. Normal sessions do not start the relay or publish this port.

The browser must reach port 1455 on the Docker host. Local Docker needs no host-networking setting.
Remote Docker needs a separate tunnel. Only one listener can use host port 1455 at a time.

Container port `61455` is in the Dynamic/Private range (`49152–65535`).
It avoids a registered service port, but another process could still occupy it.
Host port `1455` stays unchanged to match the browser callback URL.

[Documentation index](../README.md) · [CLI reference](../cli_reference.md#codex-browser-login)
