FROM alpine:3.20

# Install dependencies
RUN apk add --no-cache \
    curl \
    tar \
    ca-certificates \
    procps \
    bash \
    docker \
    git

# Set Weave Scope version
ENV SCOPE_VERSION="1.13.2"

# Create directory for Weave Scope
RUN mkdir -p /opt/weave-scope

# Download and install Weave Scope
RUN curl -L "https://github.com/weaveworks/scope/releases/download/v${SCOPE_VERSION}/scope" -o /usr/local/bin/scope && \
    chmod +x /usr/local/bin/scope

# Expose ports
EXPOSE 4040

# Set entrypoint to launch Weave Scope
ENTRYPOINT ["/usr/local/bin/scope"]

# Default command to run Weave Scope in standalone mode
CMD ["launch"]
