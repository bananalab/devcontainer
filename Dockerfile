FROM ubuntu:latest

ARG USERNAME=workshop
ARG USER_UID=1001
ARG USER_GID=1001

ENV TIMEZONE=Asia/Taipei

RUN set -x && \
    # timezone
    ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone && \
    # install packages
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
        zsh \
        # zsh-completions \
        # autojump \
        bash-completion \
        build-essential \
        gcc \
        htop \
        jq \
        less \
        llvm \
        locales \
        man-db \
        nano \
        software-properties-common \
        sudo \
        vim \
        wget \
        curl \
        gpg-agent \
        git \
        php \
        docker \
        powerline \
        fonts-powerline \
        # php extensions
        # https://github.com/dwchiang/laravel-on-aws-ecs-workshops/blob/master/section-01/Dockerfile
        bc \
        libbz2-dev \
        libfreetype6-dev \
        libpng-dev \
        libjpeg-dev \
        && \
    # for php
    apt-get install --no-install-recommends --no-install-suggests -y \
        php-gd \
        php-bcmath \
        php-bz2 \
        php-fpm \
        php-mysql \
        php-pgsql \
        php-mbstring \
        php-tokenizer \
        php-xml \
        && \
    # locale for homebrew
    # https://github.com/Linuxbrew/brew/issues/568#issuecomment-367417842
    localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    # install nodejs
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
    apt-get install --no-install-recommends --no-install-suggests -y nodejs yarn && \
    # install AWS CDK
    npm install -g aws-cdk && \    
    # add sudoer
    mkdir -p /etc/sudoers.d && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # add workshop user
    useradd -rm -d /home/$USERNAME -s /bin/zsh -g root -G sudo -u $USER_GID $USERNAME && \
    # change default dash to bash
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash && \
    # clean up
    rm -rf /var/lib/apt/lists/* 

USER $USERNAME
WORKDIR /home/$USERNAME

RUN set -x && \
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
    # install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && \
    echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/workshop/.zprofile && \
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) && \
    # install p10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k && \
    # install AWS CLI v2
    brew install awscli && \
    # install tree
    brew install tree && \
    # install docker
    brew install docker && \
    # install composer
    brew install composer && \
    # install tig
    brew install tig && \
    # install autojump
    brew install autojump

COPY --chown=workshop:root ./dotfiles/.zshrc /home/$USERNAME/
COPY --chown=workshop:root ./dotfiles/.p10k.zsh* /home/$USERNAME/


