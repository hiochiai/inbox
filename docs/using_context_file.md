## Using a Global Context File

The `inbox` tool can automatically provide a shared context or instruction file to any agent you run. This is useful for defining a consistent persona, providing project-specific information, or including frequently used instructions without passing them as arguments each time.

This context is shared globally across all agents (Gemini, Claude, etc.).

### How It Works

If a file named `CONTEXT.md` exists in your `inbox` configuration directory (`~/.inbox/`), it will be automatically copied into the active agent's profile directory on the host (e.g., `~/.inbox/claude/.claude/CLAUDE.md`) before the container starts.

The agent is pre-configured to load this file as part of its initial context.

### Setup

1.  **Create the context file:**

    Create a file named `CONTEXT.md` inside your `~/.inbox` directory.

    ```bash
    # Create an empty context file
    touch ~/.inbox/CONTEXT.md
    ```

2.  **Add your content:**

    Open the file in a text editor and add any instructions or context in Markdown format.

    ```bash
    # Example: Add content to the file
    echo "You are a helpful assistant that always responds in Japanese." > ~/.inbox/CONTEXT.md
    ```

Once the `~/.inbox/CONTEXT.md` file is created, `inbox` will handle the rest automatically. You do not need to enable any settings. To disable this feature, simply rename or delete the `CONTEXT.md` file.

### Technical Details

For transparency, the `CONTEXT.md` file (copied from `~/.inbox/CONTEXT.md`) will be made available inside each agent's container at these paths:

-   **Gemini:** `/home/node/.gemini/GEMINI.md`
-   **Claude:** `/home/node/.claude/CLAUDE.md`
