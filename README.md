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

### Documentation Matrix

| Topic | Gemini CLI | Claude Code |
| :--- | :---: | :---: |
| **Getting Started** | [Guide](./docs/gemini/getting_started.md) | [Guide](./docs/claude/getting_started.md) |
| **Google Cloud Project** | [Guide](./docs/gemini/google_cloud_project.md) | - |
| **Creating Profiles** | [Guide](./docs/gemini/creating_profiles.md) | [Guide](./docs/claude/creating_profiles.md) |
| **Switching Profiles** | [Guide](./docs/gemini/switching_profiles.md) | [Guide](./docs/claude/switching_profiles.md) |
| **Set Default Profile** | [Guide](./docs/gemini/setting_default_profile.md) | [Guide](./docs/claude/setting_default_profile.md) |
| **Passing Arguments** | - | [Guide](./docs/claude/passing_arguments.md) |
| **Using Memory Files** | [Guide](./docs/gemini/using_memory_files.md) | [Guide](./docs/claude/using_memory_files.md) |
| **Custom Tools (DooD)** | [Guide](./docs/gemini/extending_container.md) | [Guide](./docs/claude/extending_container.md) |
| **Optional Settings** | - | [Guide](./docs/claude/optional_settings.md) |

### Common Topics
* [Default Startup](./docs/default_startup.md)
* [Docker outside of Docker (DooD)](./docs/docker_outside_of_docker.md)

## Configuration

InBox uses a profile concept to manage settings for each AI. This allows you to switch between different configurations for various tasks or projects.

### Directory Structure

InBox stores configurations in `~/.inbox/` with the following structure:

```
~/.inbox/
├── gemini/                   # Default Gemini profile
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

Each profile directory is mounted to `/home/inbox` inside the container, allowing agents to access their configurations seamlessly.


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
