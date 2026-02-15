#!/bin/bash

# Get host user UID from environment variable
HOST_UID=${HOST_UID:-1000}

# Give node user password-less sudo access to apk
echo "node ALL=(ALL) NOPASSWD: /sbin/apk" > /etc/sudoers.d/node-apk
chmod 440 /etc/sudoers.d/node-apk

# Update node user's UID to match host user
usermod -u "$HOST_UID" node 2>/dev/null || true

# Fix ownership of SSH_AUTH_SOCK
if [[ -n "${SSH_AUTH_SOCK:-}" ]]; then
	chown node:node "${SSH_AUTH_SOCK}" 2>/dev/null || true
fi

# Execute the command as the node user
exec gosu node /usr/local/bin/claude "$@"