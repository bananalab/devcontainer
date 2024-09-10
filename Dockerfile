# syntax=docker/dockerfile:1

FROM ubuntu:24.04

ARG USER_UID=1001
ARG USERNAME=devcontainer
ARG USER_GID=$USER_UID

# Needed for rate limits 
# username:password
ARG GITHUB_CREDENTIAL=

ARG AWSCOPILOT_VERSION=latest
ARG CDK_VERSION=latest
ARG CHECKOV_VERSION=latest
ARG DIRENV_VERSION=latest
ARG E1S_VERSION=latest
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

ENV TIMEZONE=US/Pacific
ENV LC_ALL=C

RUN set -x && \
    export DEBIAN_FRONTEND=noninteractive && \
    # timezone
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone && \
    # install packages
    apt update && \
    apt install --no-install-recommends --no-install-suggests -y \
        build-essential \
        curl \
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
        pipx \
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

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY --chown=devcontainer:root --chmod=777 ./scripts/* /tmp/scripts/
WORKDIR /tmp/scripts
RUN ./install_ansible.sh
RUN ./install_awscli.sh
RUN ./install_awscopilot.sh
RUN ./install_azcli.sh
RUN ./install_cdk.sh
RUN ./install_checkov.sh
RUN ./install_direnv.sh
RUN ./install_docker.sh
RUN ./install_e1s.sh
RUN ./install_eksctl.sh
RUN ./install_gcloud.sh
RUN ./install_gh.sh
RUN ./install_goenv.sh
RUN ./install_gomplate.sh
RUN ./install_infracost.sh
RUN ./install_k9s.sh
RUN ./install_kubectl.sh
RUN ./install_ohmyzsh.sh
RUN ./install_packer.sh
RUN ./install_precommit.sh
RUN ./install_sops.sh
RUN ./install_terraform.sh
RUN ./install_terraformdocs.sh
RUN ./install_terragrunt.sh
RUN ./install_tflint.sh
RUN ./install_tfsec.sh
RUN ./install_tofu.sh
RUN rm -rf /tmp/scripts

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
