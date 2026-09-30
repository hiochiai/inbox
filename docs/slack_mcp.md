## Configuring MCP services

InBox runs agent-configured MCP tools inside the selected agent container. It does not install a Slack MCP server or manage external service credentials.

Use the installed agent's MCP help and the chosen server's own setup documentation. For example:

```bash
inbox claude -p work -n mcp --help
```

Configure the server in that profile, and install any required runtime using a [custom image](./claude/extending_container.md). The Antigravity image is Debian-based and does not currently install Node.js or npx; examples requiring npx need those dependencies added first.

Prefixing an InBox command with `SLACK_BOT_TOKEN=...` does not forward that variable into the container. Use the agent/server's supported configuration within the profile. Avoid putting secrets in shell history, shared examples, Dockerfiles, or image build contexts.

MCP tools can act on the external services for which you grant credentials, as well as access the mounted project and profile. Review requested permissions and the server implementation. See [security boundaries](./security.md).
