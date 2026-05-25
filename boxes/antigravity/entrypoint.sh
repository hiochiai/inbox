#!/bin/bash

# Get host user UID from environment variable
HOST_UID=${HOST_UID:-1000}

# Give inbox user password-less sudo access to apt
echo "inbox ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get" > /etc/sudoers.d/inbox-apt
chmod 440 /etc/sudoers.d/inbox-apt

# Update inbox user's UID to match host user
usermod -u "$HOST_UID" inbox 2>/dev/null || true

# Fix ownership of SSH_AUTH_SOCK
if [[ -n "${SSH_AUTH_SOCK:-}" ]]; then
	chown inbox:inbox "${SSH_AUTH_SOCK}" 2>/dev/null || true
fi

# Fix permissions for Docker socket (DooD)
if [[ -S "/var/run/docker.sock" ]]; then
	DOCKER_GROUP=$(stat -c '%G' /var/run/docker.sock)
	usermod -aG "$DOCKER_GROUP" inbox
fi

# Execute the command as the inbox user
exec gosu inbox agy "$@"
