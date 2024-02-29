#! /usr/bin/bash

# build docker image from Dockerfile with item-app:v1 tag
docker build -t item-app:v1 .
# show images list
docker images
# change image tag to ghcr url
docker tag item-app:v1 ghcr.io/airellrmdn/item-app:v1
# login to ghcr.io
echo $PASSWORD_GHCR | docker login ghcr.io --username airellrmdn --password-stdin
# push image to hub
docker push ghcr.io/airellrmdn/item-app:v1
