FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    build-essential \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22 LTS via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Install openclaw runtime globally
RUN npm install -g openclaw

# Create user with sudo
RUN useradd -m -s /bin/bash nodeuser && \
    usermod -aG sudo nodeuser && \
    echo "nodeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER nodeuser
WORKDIR /home/nodeuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=45s --retries=3 \
    CMD curl -fsS http://127.0.0.1:3000/ || exit 1

CMD ["openclaw", "gateway", "run", "--allow-unconfigured"]
