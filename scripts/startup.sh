echo "=================================== uname "; uname -a; echo "=================================== git "; git --version; echo "=================================== make "; make -v; echo "=================================== tree "; tree --version; echo "=================================== aws "; aws --version; echo "=================================== jq "; jq --version; echo "=================================== docker "; docker -v; echo "=================================== composer "; composer -V; echo "=================================== node "; node -v; echo "=================================== npm "; npm -v; echo "=================================== cdk "; cdk --version

USERNAME=workshop

# if in codespaces
if [[ $CODESPACES == 'true' ]]; then
  # change 'docker' group to gid 800 
  sudo groupmod -g 800 docker
  # add current user to `docker` group
  sudo usermod -a -G docker $USERNAME
else 
  source /home/workshop/scripts/switch-p10k-unicode.sh
fi
