#!/bin/bash

echo "Pushing changes..."
git push "$@"

if [ $? -eq 0 ]; then
    echo "=== Push successful, deploying to server ==="
    ssh root@server << 'EOF'
    echo "Pulling latest changes..."
    cd /etc/nixos && git pull
    echo "Rebuilding NixOS configuration..."
    nixos-rebuild switch
    echo "Deployment complete!"
    EOF
else
    echo "Push failed, deployment aborted"
    exit 1
fi
