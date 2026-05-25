FROM debian:13-slim

# Install necessary runtime and CLI tools
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
    && rm -rf /var/lib/apt/lists/*

# Create inbox user
RUN groupadd inbox && \
    useradd -m -g inbox -d /home/inbox inbox

# Install Antigravity CLI
RUN curl -fsSL https://antigravity.google/cli/install.sh | bash
RUN install /root/.local/bin/agy /usr/local/bin/agy

# Create workspace directory
RUN mkdir -p /workspace

# Create entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
