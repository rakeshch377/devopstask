#!/bin/bash
set -e
aws ecr get-login-password --region $3 | docker login --username AWS --password-stdin $1
docker push $1:$2

