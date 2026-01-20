#!/bin/bash

# Get host user UID and GID from environment variables
HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}

# Give node user password-less sudo access to apk
echo "node ALL=(ALL) NOPASSWD: /sbin/apk" > /etc/sudoers.d/node-apk
chmod 440 /etc/sudoers.d/node-apk

# Update node user's UID and GID to match host user
groupmod -g "$HOST_GID" node 2>/dev/null || true
usermod -u "$HOST_UID" -g "$HOST_GID" node 2>/dev/null || true

# Fix ownership of workspace and node home directory
chown -R node:node /workspace /home/node 2>/dev/null || true

# Execute the command as the node user
exec gosu node /usr/local/bin/gemini "$@"