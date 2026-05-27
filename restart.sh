#!/bin/bash

# Source the local variables into the host shell session
source env.sh

echo "Initializing stack with model: litellm/$MODEL_NAME"

# Check if openclaw-service is missing or dead
if [ -z "$(docker ps -q -f name=openclaw-service)" ]; then
    echo "Container missing or stopped. Starting it up..."
    docker compose up -d openclaw
else
    echo "Container is already running. Forcing recreation to pick up fresh env changes..."
    # --no-deps ensures we only recreate openclaw without bouncing litellm
    docker compose up -d --force-recreate --no-deps openclaw
fi

# Give the internal socket a brief window to bind
sleep 2

# Verify the container picked up everything smoothly
docker exec -it openclaw-service openclaw config validate

# Drop straight into your interactive AI workspace
docker exec -it openclaw-service openclaw chat