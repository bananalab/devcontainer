#!/bin/bash -uex
if [ ${KUBECTL_VERSION} == "latest" ]; then
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
fi
ARCH=$(uname -i)
case ${ARCH} in
    aarch64 | arm64)
        curl -sLO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/arm64/kubectl;
        curl -sLO "https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/arm64/kubectl.sha256";
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check;
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl;
        ;;
    *)
        curl -sLO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl;
        curl -sLO "https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256";
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check;
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl;
        ;;
esac
rm -f kubectl.sha256