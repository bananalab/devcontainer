#!/bin/bash -uex
export ARCH=$(uname -i)
case ${ARCH} in
    aarch64)
        curl -sf "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" ;
        unzip awscliv2.zip ;
        ./aws/install ;
        ;;
    *)
        curl -sf "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ;
        unzip awscliv2.zip ;
        ./aws/install ;
        ;;
esac
rm awscliv2.zip
rm -rf aws