# InBox

**InBox** is a containerized sandbox wrapper for AI agents like Gemini CLI and Claude Code. It provides a secure, isolated environment for AI interactions without requiring local installation of Node.js or agent-specific dependencies.

## Why InBox?

- **🔒 Secure Isolation**: AI agents run in isolated Docker containers
- **🧹 Clean Host System**: No need to install Node.js or dependencies locally  
- **⚡ Full Command Access**: Containerized environment supports all commands safely
- **👤 Multi-Profile Support**: Easy switching between authenticated users and project configurations
- **🚀 Zero Setup**: Just Docker required - everything else is handled automatically

## Prerequisites

- Docker (running and accessible)

## Installation

```bash
# Download and install InBox
curl -L -o inbox https://github.com/hiochiai/inbox/releases/latest/download/inbox
chmod +x inbox
sudo mv inbox /usr/local/bin/

# Verify installation
inbox version
```

## Quick Start

### Getting Started with Gemini

#### 1. Initial Setup

```bash
inbox gemini
```

Follow the prompts: select a theme and choose "Login with Google".

#### 2. Get Authentication URL

```bash
inbox gemini
```

Copy the URL displayed in the terminal and open it in your browser.

#### 3. Complete Authentication

* Log in with your Google account and grant the necessary permissions.
* Copy the verification code shown in the browser and paste it into your terminal.

#### 4. Start Using Gemini

```bash
inbox gemini
```

#### Configure Google Cloud Project (Optional)

You can set your project ID for the default profile with this command:

```bash
cat << EOF >$(inbox profile path gemini)/.gemini/.env
GOOGLE_CLOUD_PROJECT=your-project-id
EOF
```

### Getting Started with Claude

#### 1. Start Authentication

```bash
inbox claude
```

#### 2. Authenticate in Browser

* Copy the displayed URL, open it in your browser, and log in.
* Copy the verification code and paste it into your terminal.

#### 3. Container Setup

* When prompted about "Bypass Permissions mode," select "Yes" (this is required for the container environment).

#### 4. Start Using Claude

```bash
inbox claude
```

#### Configure Claude Settings (Optional)

To disable non-essential traffic, add the following configuration:
```bash
cat << EOF > ~/.inbox/claude/.claude/settings.json
{
  "env": {
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
EOF
```

## Usage

### Basic Commands

```bash
# Run specific agent
inbox gemini
inbox claude

# Run default agent (after setting one)
inbox

# Use specific profile
inbox gemini -p work-profile
inbox claude -p personal

# Pass arguments to agent
inbox gemini --help
inbox claude --version

# Skip default flags
inbox gemini -n
```

### Profile Management

```bash
# List all profiles
inbox profile list

# Show profile configuration path
inbox profile path gemini              # Default profile
inbox profile path claude work-profile # Named profile

# Set default agent and profile
inbox profile set-default gemini work-profile

# Show current default
inbox profile default

# Use default agent (after setting)
inbox
```


## Configuration

### Directory Structure

InBox stores configurations in `~/.inbox/` with the following structure:

```
~/.inbox/
├── gemini/                    # Default Gemini profile
│   └── .gemini/
│       ├── settings.json
│       └── GEMINI.md         # Optional memory file
├── gemini-work/              # Named profile example
│   └── .gemini/...
├── claude/                   # Default Claude profile  
│   └── .claude/
│       ├── settings.json
│       └── CLAUDE.md         # Optional memory file
└── claude-personal/          # Named profile example
    └── .claude/...
```

Each profile directory is mounted to `/home/node` inside the container, allowing agents to access their configurations seamlessly.


### Memory Files

Place `GEMINI.md` or `CLAUDE.md` files in the respective profile directories to provide persistent context to your AI agents.

## Advanced Usage

### Custom Profiles for Different Projects

```bash
# Create work profile
inbox gemini -p work
# (Complete authentication for work account)

# Create personal profile  
inbox claude -p personal
# (Complete authentication for personal account)

# Set default for quick access
inbox profile set-default claude personal

# Switch between profiles
inbox gemini -p work      # Use work Gemini
inbox claude -p personal  # Use personal Claude
inbox                     # Use default (personal Claude)
```

## Troubleshooting

### Common Issues

**Docker Permission Errors**
```bash
# Ensure Docker is running and accessible
docker ps

# On Linux, add user to docker group
sudo usermod -aG docker $USER
# Then logout and login again
```

**Authentication Issues**
```bash
# Clear profile and re-authenticate
rm -rf ~/.inbox/gemini
inbox gemini  # Start fresh setup
```

**Profile Not Found**
```bash
# List available profiles
inbox profile list

# Check profile path
inbox profile path gemini my-profile
```

## Uninstallation

```bash
# Remove InBox binary
sudo rm /usr/local/bin/inbox

# Remove all configurations and profiles
rm -rf ~/.inbox

# Remove Docker image
docker rmi ghcr.io/hiochiai/inbox:latest
```

> [!WARNING]
> Removing `~/.inbox` will delete all your profiles and authentication data.