## Quick Start for Codex

### 1. Initial Setup

```bash
inbox codex
```

When the authentication options appear, select **Sign in with Device Code**.

**Sign in with ChatGPT** redirects your browser to `127.0.0.1:1455`, but Codex listens inside the container. The host browser cannot reach the container's loopback interface, so use device code authentication with InBox.

### 2. Open the Authentication URL

Copy the URL displayed in the terminal and open it in your browser.

If device code login is unavailable, enable it in your ChatGPT security settings or ask your workspace administrator to enable it.

### 3. Complete Authentication

1. Sign in with your ChatGPT account.
2. Enter the one-time code displayed in the terminal into the browser.
3. Wait for the CLI to confirm successful authentication.

### 4. Start Using Codex

Continue in the current session, or start Codex again:

```bash
inbox codex
```


[Documentation index](../README.md) · [Manage profiles](../profiles.md)
