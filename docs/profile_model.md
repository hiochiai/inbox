## Understand profiles and containers

A profile is a persistent container home. A container is a temporary process environment created for one launch. Keeping these separate lets you reuse credentials and settings while replacing the runtime environment.

```text
Host                                   Container
~/.inbox/claude-work  -- read-write -->  /home/inbox
current project      -- read-write -->  /workspace
selected image       -- supplies -->   agent and installed tools

Exit: container removed; profile and project remain.
```

### What belongs to a profile?

The agent controls the files it writes in its home: authentication, settings, caches, and session state may persist there. InBox mounts that directory; it does not translate credentials between agents.

`claude-work` and `codex-work` are different homes even though both profiles are named `work`. The same profile can be reused from different project directories. The current project is mounted separately and remains writable.

### Where do tools live?

Tools installed in a custom image are available whenever that image is selected. Changes elsewhere in a running container's writable layer disappear when it exits. Files written into the mounted home or project remain. This is why repeatable system tools belong in a profile Dockerfile.

The Dockerfile is stored in the profile, but building an image is explicit. Image selection follows the [CLI reference](./cli_reference.md#image-selection); a tagged override can bypass the profile image.

### What does separation guarantee?

Profiles organize identities and state. They are not protection against a hostile agent with Docker socket access, and they do not make project edits disposable. The [security model](./security.md) describes writable mounts, approval defaults, and host integrations.

[Documentation index](./README.md) · [Manage profiles](./profiles.md) · [Build a custom image](./custom_images.md)
