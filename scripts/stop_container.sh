#!/bin/bash
set -e

echo "Step 1: Remove ALL containers (running + stopped)"
docker rm -f $(docker ps -aq) 2>/dev/null || true

echo "Step 2: Remove dangling images"
docker image prune -af

echo "Step 3: Remove unused images (extra safety)"
docker rmi -f $(docker images -f "dangling=true" -q) 2>/dev/null || true

echo "Cleanup completed"
