set -e

echo "Updating OH_MY_ZSH settings"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="steeef"/g' ~/.zshrc
source ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
sed -i 's/(git)/(git zsh-syntax-highlighting zsh-autosuggestions history-substring-search)/g' ~/.zshrc
source ~/.zshrc
echo "Removing redundant packages"
sudo apt autoremove
