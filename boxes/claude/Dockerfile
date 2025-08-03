FROM node:24-alpine

ARG CLAUDE_CODE_VERSION=latest

RUN apk add --no-cache \
    bash \
    curl \
    git \
    shadow \
    gosu

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

# Create workspace directory
RUN mkdir -p /workspace

# Create entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
