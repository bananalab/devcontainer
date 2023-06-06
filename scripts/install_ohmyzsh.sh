#!/bin/bash -uex

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o omz_install.sh
chmod +x ./omz_install.sh
ZDOTDIR=/etc/skel sh -c ./omz_install.sh --skip-chsh --unattended --keep-zshrc
rm -f omz_install.sh

cat << EOF > /etc/skel/.zshrc
export ZSH="\$HOME/ohmyzsh"
ZSH_THEME="robbyrussell"
plugins=( aws direnv gh git terraform )
source \$ZSH/oh-my-zsh.sh

# Enable Docker in Docker
if [ -e /var/run/docker.sock ]; then
    sudo chmod 775 /var/run/docker.sock
fi
EOF