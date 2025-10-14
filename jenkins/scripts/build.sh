#!/bin/bash
set -e
docker build -t $1:$2 ./app

