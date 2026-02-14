## Using Memory Files with Gemini

Memory files allow you to provide persistent context to the Gemini agent across multiple conversations.

### How It Works

Place a `GEMINI.md` file in your profile directory to provide persistent context. The agent is pre-configured to load this file as part of its initial context.

### Setup

1. **Create the memory file:**

   The memory file should be placed in your profile's configuration directory. For the default profile:

   ```bash
   # Create an empty memory file
   touch ~/.inbox/gemini/.gemini/GEMINI.md
   ```

   For a named profile, replace `gemini` with `gemini-<profile-name>`:

   ```bash
   touch ~/.inbox/gemini-myprofile/.gemini/GEMINI.md
   ```

2. **Add your content:**

   Open the file in a text editor and add any instructions or context in Markdown format.

   ```bash
   # Example: Add content to the file
   echo "You are a helpful assistant that always responds in Japanese." > ~/.inbox/gemini/.gemini/GEMINI.md
   ```

### File Location

Inside the Gemini container, the memory file is available at:

- **Path:** `/home/node/.gemini/GEMINI.md`

The agent automatically loads this file when starting, so you don't need to enable any settings. To disable this feature, simply delete or rename the `GEMINI.md` file.