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

## Usage

### Getting Started
* Getting Started ([Gemini](./docs/gemini/getting_started.md)) ([Claude](./docs/claude/getting_started.md))
* Getting Started with GOOGLE_CLOUD_PROJECT ([Gemini](./docs/gemini/google_cloud_project.md))

### Profile Management
* [Default Startup](./docs/default_startup.md)
* Creating Profiles ([Gemini](./docs/gemini/creating_profiles.md)) ([Claude](./docs/claude/creating_profiles.md))
* Switching Profiles ([Gemini](./docs/gemini/switching_profiles.md)) ([Claude](./docs/claude/switching_profiles.md))
* Setting a Default Profile ([Gemini](./docs/gemini/setting_default_profile.md)) ([Claude](./docs/claude/setting_default_profile.md))

### Interacting with AI
* Passing Arguments ([Gemini](./docs/gemini/passing_arguments.md)) ([Claude](./docs/claude/passing_arguments.md))
* Using Memory Files ([Gemini](./docs/gemini/using_memory_files.md)) ([Claude](./docs/claude/using_memory_files.md))
* [Using a Global Context File](./docs/using_context_file.md)
* Disabling Non-Essential Traffic ([Claude](./docs/claude/optional_settings.md))


## Configuration

InBox uses a profile concept to manage settings for each AI. This allows you to switch between different configurations for various tasks or projects.

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
inbox profile gemini my-profile
```

## Uninstallation

```bash
# Remove InBox binary
sudo rm /usr/local/bin/inbox

# Remove all configurations and profiles
rm -rf ~/.inbox

# Remove Docker image
docker images --format "{{.Repository}}:{{.Tag}}" \
  | grep '^ghcr.io/hiochiai/inbox:' \
  | xargs docker rmi
```

> [!WARNING]
> Removing `~/.inbox` will delete all your profiles and authentication data.