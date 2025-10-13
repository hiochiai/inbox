## Extending the Container & Custom Tools

`inbox` allows you to extend the container environment for each profile to pre-install any custom tools you need, such as `go`, `cargo`, or various other CLI tools.

This feature enables you to expand the capabilities of the AI agent, allowing it to perform more advanced tasks.

### Workflow

1.  **Create a Profile**:
    First, create a profile that will serve as the base for your customizations.
    ```bash
    # Create a profile named 'work' for the 'claude' agent
    inbox claude -p work
    ```

2.  **Place the Dockerfile**:
    Next, place your custom `Dockerfile` in the profile's configuration directory. The script combines the agent and profile name to create the directory.

    For a named profile like `work`, the path is `~/.inbox/claude-work/Dockerfile`.
    ```bash
    # The profile directory is created automatically, so just place the Dockerfile
    touch ~/.inbox/claude-work/Dockerfile
    ```
    > [!NOTE]
    > For the default profile (when no `-p` flag is used), the path is `~/.inbox/claude/Dockerfile`.

3.  **Edit the Dockerfile**:
    Edit the `Dockerfile` to add the commands for installing your desired tools.

    > [!IMPORTANT]
    > You **must** use the official `inbox` image in the `FROM` instruction. Using a different base image will cause the core functionalities of `inbox` to be lost.

    **Sample Dockerfile (`~/.inbox/work/Dockerfile`)**
    ```dockerfile
    # Use the inbox Claude image as the base
    FROM ghcr.io/hiochiai/inbox:latest-claude

    # Example: Install go using apk
    # RUN apk update && apk add --no-cache go
    ```

4.  **Build the Custom Image**:
    Run the `inbox profile build-image` command to build the custom image from your `Dockerfile`. This command is explicit and consistent with other `profile` subcommands. Run it whenever you update your `Dockerfile`.

    ```bash
    # Build the custom image for the 'work' profile of the 'claude' agent
    inbox profile build-image claude work
    ```

5.  **Use the Custom Profile**:
    Once the build is complete, start `inbox` as usual, specifying the agent and profile.

    ```bash
    # Start a session in the container with custom tools installed
    inbox claude -p work
    ```

> [!WARNING]
> **Security Risk**: This feature allows arbitrary code execution, which is powerful but also carries security risks. Do not use `Dockerfile`s from untrusted sources, as they could lead to unauthorized access to your host system or the installation of malicious software.
