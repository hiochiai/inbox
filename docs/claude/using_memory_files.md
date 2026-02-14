## Using Memory Files with Claude

Memory files allow you to provide persistent context to the Claude agent across multiple conversations.

### How It Works

Place a `CLAUDE.md` file in your profile directory to provide persistent context. The agent is pre-configured to load this file as part of its initial context.

### Setup

1. **Create the memory file:**

   The memory file should be placed in your profile's configuration directory. For the default profile:

   ```bash
   # Create an empty memory file
   touch ~/.inbox/claude/.claude/CLAUDE.md
   ```

   For a named profile, replace `claude` with `claude-<profile-name>`:

   ```bash
   touch ~/.inbox/claude-myprofile/.claude/CLAUDE.md
   ```

2. **Add your content:**

   Open the file in a text editor and add any instructions or context in Markdown format.

   ```bash
   # Example: Add content to the file
   echo "You are a helpful assistant that always responds in Japanese." > ~/.inbox/claude/.claude/CLAUDE.md
   ```

### File Location

Inside the Claude container, the memory file is available at:

- **Path:** `/home/node/.claude/CLAUDE.md`

The agent automatically loads this file when starting, so you don't need to enable any settings. To disable this feature, simply delete or rename the `CLAUDE.md` file.