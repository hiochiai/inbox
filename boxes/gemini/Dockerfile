FROM node:24-alpine

ARG GEMINI_CLI_VERSION=latest

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
    && apk add --no-cache --virtual .build-deps \
        build-base \
        python3 \
    && npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION} \
    && npm cache clean --force \
    && apk del .build-deps \
    && usermod -l inbox node \
    && usermod -d /home/inbox -m inbox \
    && groupmod -n inbox node \
    && mkdir -p /workspace

# Create entrypoint script
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

