FROM debian:13-slim

# Install necessary runtime, user setup, and Antigravity CLI
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    gnupg \
    lsb-release \
    openssh-client \
    gosu \
    sudo \
    coreutils \
    ca-certificates \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get install -y --no-install-recommends \
    docker-ce-cli \
    docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd inbox \
    && useradd -m -g inbox -d /home/inbox inbox \
    && curl -fsSL https://antigravity.google/cli/install.sh | bash \
    && install /root/.local/bin/agy /usr/local/bin/agy \
    && rm -rf /root/.local/bin/agy /root/.cache/antigravity \
    && mkdir -p /workspace

# Create entrypoint script
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

