#! /usr/bin/bash

# build docker image from Dockerfile
docker build -t ghcr.io/airellrmdn/karsajobs-ui:latest .
# login to ghcr.io
echo $PASSWORD_GHCR | docker login ghcr.io --username airellrmdn --password-stdin
# push image to hub
docker push ghcr.io/airellrmdn/karsajobs-ui:latest
