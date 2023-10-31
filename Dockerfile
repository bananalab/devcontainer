# syntax=docker/dockerfile:1
FROM docker as docker

FROM ubuntu:latest
COPY --from=docker /usr/local/libexec/docker/cli-plugins/docker-buildx /usr/libexec/docker/cli-plugins/docker-buildx

ARG USER_UID=1000
ARG USERNAME=devcontainer
ARG USER_GID=$USER_UID

# Needed for rate limits 
# username:password
ARG GITHUB_CREDENTIAL=

ARG AWSCOPILOT_VERSION=latest
ARG CDK_VERSION=latest
ARG CHECKOV_VERSION=latest
ARG DIRENV_VERSION=latest
ARG EKSCTL_VERSION=latest
ARG INFRACOST_VERSION=latest
ARG GO_VERSION=latest
ARG GOENV_VERSION=latest
ARG GOMPLATE_VERSION=latest
ARG K9S_VERSION=latest
ARG KUBECTL_VERSION=latest
ARG NODE_VERSION=18
ARG PRECOMMIT_VERSION=latest
ARG PROJEN_VERSION=latest
ARG SOPS_VERSION=latest
ARG TERRAFORM_DOCS_VERSION=latest
ARG TERRAFORM_VERSION=latest
ARG TERRAGRUNT_VERSION=latest
ARG TFENV_VERSION=latest
ARG TFLINT_VERSION=latest
ARG TFSEC_VERSION=latest
ARG TOFU_VERSION=latest

ENV LC_ALL=C
ENV TIMEZONE=US/Pacific

RUN set -x && \
    export DEBIAN_FRONTEND=noninteractive && \
    # timezone
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone && \
    # install packages
    apt update && \
    apt install --no-install-recommends --no-install-suggests -y \
        build-essential \
        curl \
        docker \
        docker-compose \
        docker.io \
        gcc \
        git \
        gpg-agent \
        htop \
        jq \
        less \
        llvm \
        locales \
        man-db \
        openssh-client \
        python-is-python3 \
        python3-pip \
        software-properties-common \
        sudo \
        tree \
        unzip \
        vim \
        wget \
        zsh && \
        rm -rf /var/lib/apt/lists/*

COPY --chown=devcontainer:root --chmod=777 ./scripts/* /tmp/scripts/
RUN for f in /tmp/scripts/*.sh; do bash -uex "$f" || false; done

RUN set -x &&\
    # add sudoer
    mkdir -p /etc/sudoers.d && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # add group & user
    groupadd -g $USER_GID $USERNAME && \
    useradd -rm -d /home/$USERNAME -s /bin/zsh -g $USER_GID -G root,sudo,docker -u $USER_UID $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME
CMD ["/bin/zsh"]
