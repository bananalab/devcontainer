FROM ubuntu:latest

ARG USER_UID=1000
ARG USERNAME=bootcamp
ARG USER_GID=$USER_UID

ARG AWSCOPILOT_VERSION=latest
ARG CDK_VERSION=latest
ARG CHECKOV_VERSION=latest
ARG DIRENV_VERSION=latest
ARG EKSCTL_VERSION=latest
ARG INFRACOST_VERSION=latest
ARG K9S_VERSION=latest
ARG KUBECTL_VERSION=latest
ARG NODE_VERSION=18
ARG PRECOMMIT_VERSION=latest
ARG SOPS_VERSION=latest
ARG TERRAFORM_DOCS_VERSION=latest
ARG TERRAFORM_VERSION=latest
ARG TERRAGRUNT_VERSION=latest
ARG TFENV_VERSION=latest
ARG TFLINT_VERSION=latest
ARG TFSEC_VERSION=latest

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

RUN set -x &&\   
    # add sudoer
    mkdir -p /etc/sudoers.d && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # add group & user
    groupadd -g $USER_GID $USERNAME && \
    useradd -rm -d /home/$USERNAME -s /bin/zsh -g $USER_GID -G root,sudo,docker -u $USER_UID $USERNAME

COPY --chown=workshop:root --chmod=777 ./scripts/* /tmp/scripts/

RUN for f in /tmp/scripts/*.sh; do bash -uex "$f" || false; done

USER $USERNAME
WORKDIR /home/$USERNAME

RUN bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY --chown=workshop:workshop ./dotfiles /home/$USERNAME/
