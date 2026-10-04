## Understand profiles and containers

A profile stores an agent's login, settings, and other saved files.
A container runs the agent. InBox removes the container when the session ends.

```text
Host                              Container
~/.inbox/claude-work  ---------->  /home/inbox  (writable)
current project      ---------->  /workspace   (writable)
selected image       ---------->  agent and tools

After exit: the profile and project remain on the host.
```

### What belongs to a profile?

The agent chooses which files to save in its home directory. These may include credentials, settings, caches, and session history.
InBox keeps these files in the profile directory.

Claude's `work` profile and Codex's `work` profile are separate. They do not share credentials.
You can use the same profile in different projects.

### Where do tools live?

An image supplies the agent and installed tools. Add tools with a [custom image](./custom_images.md) to keep them across sessions.
Changes outside the mounted profile and project disappear when the container exits.

A profile Dockerfile defines its custom image. You must build it before use.
See [image selection](./cli_reference.md#image-selection) for overrides.

### What does separation guarantee?

Profiles keep accounts and settings separate. They do not prevent project edits or protect against an agent with host Docker access.
See the [security model](./security.md) for access limits.

[Documentation index](./README.md) · [Manage profiles](./profiles.md)
