FROM node:24-alpine

ARG TARGETPLATFORM
ARG CODEX_VERSION=latest

RUN set -eux; \
    echo "Building Codex for ${TARGETPLATFORM}"; \
    uname -m; \
    cat /etc/alpine-release; \
    apk add --no-cache \
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
    procps

RUN set -eux; node --version; npm --version

RUN set -eux; npm install -g "@openai/codex@${CODEX_VERSION}"

RUN set -eux; npm cache clean --force

RUN set -eux; \
    usermod -l inbox node; \
    usermod -d /home/inbox -m inbox; \
    groupmod -n inbox node; \
    mkdir -p /workspace

# Create entrypoint script
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

COPY sign-in-with-chatgpt.cjs /usr/local/lib/inbox/sign-in-with-chatgpt.cjs

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

