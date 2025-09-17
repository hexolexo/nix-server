#!/bin/bash

git push "$@"

if [ $? -eq 0 ]; then
    ssh root@server "cd /etc/nixos && git pull && nixos-rebuild switch" && timeout 5 git push github master
else
    echo "Push failed, deployment aborted"
    exit 1
fi
