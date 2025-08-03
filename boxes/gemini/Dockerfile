FROM node:24-alpine

ARG GEMINI_CLI_VERSION=latest

RUN apk add --no-cache \
    bash \
    curl \
    git \
    shadow \
    gosu

# Install Gemini CLI globally
RUN npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION}

# Create workspace directory
RUN mkdir -p /workspace

# Create entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
