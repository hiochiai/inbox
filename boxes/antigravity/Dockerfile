FROM debian:13-slim

# Install necessary runtime, user setup, and Antigravity CLI
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    docker.io \
    git \
    openssh-client \
    gosu \
    sudo \
    coreutils \
    ca-certificates \
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

