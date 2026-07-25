FROM node:24-alpine

ARG CLAUDE_CODE_VERSION=latest

RUN apk add --no-cache \
    bash \
    curl \
    docker-cli \
    docker-cli-compose \
    git \
    openssh-client \
    shadow \
    gosu \
    sudo \
    coreutils \
    && npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION} \
    && npm cache clean --force \
    && usermod -l inbox node \
    && usermod -d /home/inbox -m inbox \
    && groupmod -n inbox node \
    && mkdir -p /workspace

# Create entrypoint script
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

