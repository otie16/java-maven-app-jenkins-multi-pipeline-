#!/usr/bin/env/groovy

# Receiving the image name as a parameter
export IMAGE_NAME=$1
docker-compose -f docker-compose.yaml up --detach
echo "success"
