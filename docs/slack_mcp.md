## Using Slack MCP Server

The Model Context Protocol (MCP) allows agents like Antigravity and Claude Code to interact with external services like Slack.

### Prerequisites

You will need a Slack Bot Token and Team ID.
- **SLACK_BOT_TOKEN**: Starts with `xoxb-`.
- **SLACK_TEAM_ID**: Found in your Slack workspace URLs.

### 1. Using Antigravity

Antigravity uses an `mcp_config.json` file. You can configure it by editing the file in your profile directory.

#### Locate Config

```bash
inbox profile antigravity
# Example Output: /home/user/.inbox/antigravity
```

#### Edit Config

Edit `~/.inbox/antigravity/.gemini/antigravity-cli/mcp_config.json` (or similar path depending on version) to include:

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-your-token",
        "SLACK_TEAM_ID": "T12345"
      }
    }
  }
}
```

### 2. Using Claude Code

You can add the Slack MCP server directly from within the container or via the `inbox` command.

#### Setup via InBox

```bash
# Add the Slack MCP server to Claude Code
inbox claude mcp add slack npx -y @modelcontextprotocol/server-slack
```

You may be prompted to provide environment variables. Alternatively, you can pass them:

```bash
SLACK_BOT_TOKEN=xoxb-... SLACK_TEAM_ID=T... inbox claude mcp add slack npx -y @modelcontextprotocol/server-slack
```

### 3. Usage Examples

Once configured, you can ask the agent:
- "Search for messages about 'deployment' in #general"
- "Send a message to @dev-team saying the tests passed"
- "Summarize the last 5 messages in the #engineering channel"
