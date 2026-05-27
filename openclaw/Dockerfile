FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    NODE_MAJOR=24

# 1. Base Environment Provisioning
RUN apt-get update && apt-get install -y \
    curl ca-certificates gnupg dos2unix nano wget \
    python3 python3-pip python3-dev build-essential \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y nodejs \
    && npm install -g openclaw@latest \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Dependency Injection for Quantitative Analysis
RUN pip3 install --no-cache-dir mootdx requests pandas stockstats

# 3. Local Workspace Target Mapping
RUN mkdir -p /root/.openclaw/workspace/skills/a-stock-data

WORKDIR /root

# 4. Entrypoint Scaffolding
RUN echo '#!/bin/bash\n\
# Seed the golden config if it exists\n\
mkdir -p /root/.openclaw\n\
if [ -f /staging/openclaw.json ]; then\n\
    cp /staging/openclaw.json /root/.openclaw/openclaw.json\n\
    echo "Golden configuration seeded."\n\
fi\n\
openclaw gateway start > /var/log/openclaw.log 2>&1 &\n\
echo "Gateway System Initialization Complete."\n\
tail -f /dev/null' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
