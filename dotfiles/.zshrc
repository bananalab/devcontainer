export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=( aws direnv gh git terraform )
source $ZSH/oh-my-zsh.sh

# Enable Docker in Docker
sudo chmod 775 /var/run/docker.sock