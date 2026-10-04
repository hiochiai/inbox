## Quick Start for Gemini

Gemini is deprecated in InBox. This guide is for existing users.

Install [InBox](../installation.md) and start Docker.

### 1. Initial Setup

Run this in your host terminal, from your project directory:

```bash
inbox gemini -p work -n
```

Follow the setup prompts and choose the login method for your account.
`-n` omits InBox's default flag that skips approvals; your project remains writable.

### 2. Get Authentication URL

When the agent displays a login URL, open it in your browser.
Keep the terminal session open while signing in.

### 3. Complete Authentication

Follow the browser instructions. If a verification code is shown, enter it when the terminal asks.
Your saved profile files remain in `~/.inbox/gemini-work`.

### 4. Start Using Gemini

After signing in, continue in the current session.
To return later, exit and run the same command:

```bash
inbox gemini -p work -n
```

[Documentation index](../README.md) · [Manage profiles](../profiles.md) · [Security model](../security.md)
