## Configuring MCP services

MCP servers give agents tools for services such as Slack.
InBox does not install a Slack server or manage its credentials.

1. Check the agent's MCP setup commands from your host terminal:

   ```bash
   inbox claude -p work -n -- mcp --help
   ```

2. Follow your chosen server's setup guide. Save its configuration in the same `work` profile.
   Add required runtimes through a [custom image](./custom_images.md).

3. Restart the profile and check that the agent lists the configured tools:

   ```bash
   inbox claude -p work -n
   ```

InBox does not forward host environment variables automatically.
For tokens, use the agent or server's configuration in the profile.
Keep secrets out of shell history, Dockerfiles, and shared examples.

The Antigravity image does not include Node.js or `npx`. Add them before using a server that needs them.
MCP tools can access configured services and mounted files; see the [security model](./security.md).

[Documentation index](./README.md) · [CLI reference](./cli_reference.md)
