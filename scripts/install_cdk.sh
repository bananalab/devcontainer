#!/bin/bash -uex
if [ ${NODE_VERSION} == "latest" ]; then 
    NODE_DOWNLOAD_URL="https://deb.nodesource.com/setup_current.x" 
else 
    NODE_DOWNLOAD_URL="https://deb.nodesource.com/setup_${NODE_VERSION}.x" 
fi
curl -fsL --show-error ${NODE_DOWNLOAD_URL} -o install_node
bash install_node
apt update -y
apt install --no-install-recommends --no-install-suggests -y nodejs yarn 
npm install -g aws-cdk@${CDK_VERSION}