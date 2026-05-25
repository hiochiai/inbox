## Using Memory Files with Antigravity

Memory files allow you to provide persistent context to the Antigravity agent across multiple conversations.

### How It Works

Place a `GEMINI.md` file in your profile directory to provide persistent context. The agent is pre-configured to load this file as part of its initial context.

### Setup

1. **Create the memory file:**

   The memory file should be placed in your profile's configuration directory. For the default profile:

   ```bash
   # Create an empty memory file
   touch ~/.inbox/antigravity/.gemini/GEMINI.md
   ```

   For a named profile, replace `antigravity` with `antigravity-<profile-name>`:

   ```bash
   touch ~/.inbox/antigravity-myprofile/.gemini/GEMINI.md
   ```

2. **Add your content:**

   Open the file in a text editor and add any instructions or context in Markdown format.

### File Location

Inside the Antigravity container, the memory file is available at:

- **Path:** `/home/inbox/.gemini/GEMINI.md`

The agent automatically loads this file when starting. To disable this feature, simply delete or rename the `GEMINI.md` file.
