#!/bin/bash

json=$(printf '{"model": "%s", "messages": [{"role": "user", "content": "hi, who are you?"}]}' "$MODEL_NAME")

curl http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-stack-master-key" \
  -H "Content-Type: application/json" \
  -d "$json"
