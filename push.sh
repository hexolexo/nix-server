#!/bin/bash

echo "Pushing changes..."
git push "$@"

if [ $? -eq 0 ]; then
    echo "=== Push successful, deploying to server ==="
    ssh root@server "cd /etc/nixos && git pull && nixos-rebuild switch"
else
    echo "Push failed, deployment aborted"
    exit 1
fi
