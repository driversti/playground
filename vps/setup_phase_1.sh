set -e

sudo apt update
#sudo apt install openssh-server nano git wget -y
sudo apt install nano git wget curl zip unzip -y
echo "Existing updates:"
sudo apt list --upgradable
printf "Would you like to upgrade the system? [y/n]: "
read -r upgrade_resp
if [ "$upgrade_resp" = "y" ]; then
    sudo apt upgrade -yy
else
  echo "Upgrading skipped"
fi
echo "Installing sdkman and the latest LTS java"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
sdk install java
sudo apt install zsh -y
zsh --version
sudo chsh -s "$(which zsh)"
echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
