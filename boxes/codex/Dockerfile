FROM node:24-alpine

ARG CODEX_VERSION=latest

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
    procps \
    && npm install -g @openai/codex@${CODEX_VERSION} \
    && npm cache clean --force \
    && usermod -l inbox node \
    && usermod -d /home/inbox -m inbox \
    && groupmod -n inbox node \
    && mkdir -p /workspace

# Create entrypoint script
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

COPY sign-in-with-chatgpt.cjs /usr/local/lib/inbox/sign-in-with-chatgpt.cjs

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

