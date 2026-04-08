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

# Create user with sudo
RUN useradd -m -s /bin/bash nodeuser && \
    usermod -aG sudo nodeuser && \
    echo "nodeuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER nodeuser
WORKDIR /home/nodeuser

CMD ["tail", "-f", "/dev/null"]
