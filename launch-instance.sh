#!/bin/bash

image=littlejo/aws-environment
aws_region=us-east-1

root_container_dir=$(mktemp -d /tmp/root-docker-XXXXXXXX)
share_container_dir=$HOME/share-docker

docker run -it -v $root_container_dir:/root \
               -v $share_container_dir:/share \
               -e AWS_ACCESS_KEY_ID=$1 \
               -e AWS_SECRET_ACCESS_KEY=$2 \
               -e AWS_DEFAULT_REGION=$aws_region \
               --rm $image /var/tmp/post-install.sh
