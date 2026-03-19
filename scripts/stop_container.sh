#!/bin/bash
set -e

echo "Stopping and removing running containers..."

containers=$(docker ps -q)

if [ -n "$containers" ]; then
  docker rm -f $containers
else
  echo "No running containers"
fi

echo "Removing dangling images (untagged)..."
docker image prune -f

echo "Removing old images except latest..."

# Get latest image ID
latest_image=$(docker images --format "{{.Repository}}:{{.Tag}} {{.ID}}" | grep 'latest' | awk '{print $2}')

# Remove all images except latest
docker images --format "{{.ID}}" | grep -v "$latest_image" | xargs -r docker rmi -f

echo "Cleanup completed"
