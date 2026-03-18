#!/bin/bash
set -e

# Stop the running container (if any)
containers=$(docker ps -q)

if [ -n "$containers" ]; then
  docker rm -f $containers
else
  echo "No running containers"
fi
