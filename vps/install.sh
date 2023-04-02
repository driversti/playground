#!/bin/bash

apt update
apt install nano git wget curl zip unzip sudo -y

# Create a new user called 'testuser'
adduser --gecos "" testuser

# Grant 'testuser' sudo privileges
usermod -aG sudo testuser

# Set the password for the testuser
echo "Enter a password for the new user 'testuser':"
passwd testuser

# Print success message
echo "User 'testuser' created successfully with sudo privileges."

# Switch to the new user
su - testuser << 'EOF'
# Install Zsh
sudo apt install zsh -y
sudo chsh -s "$(which zsh)" $USER

# Exit the subshell
EOF

# Switch to the testuser with zsh as a shell
su - testuser -s /bin/zsh << 'EOF'

# Install Oh-My-Zsh for the new user
echo "Installing Oh-My-Zsh for testuser"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# Update Oh-My-Zsh settings
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="steeef"/g' ~/.zshrc

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Enable plugins
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions history-substring-search)/g' ~/.zshrc

# Load the new configuration
source ~/.zshrc

# Exit the subshell
EOF

# Switch to the new user with zsh shell
printf "Script execution finished.\n\nWould you like to switch to the testuser with the Zsh shell now? [y/n]: "
read -r switch_to_testuser

if [ "$switch_to_testuser" = "y" ]; then
    su - testuser -s /bin/zsh
else
    echo "You can switch to the testuser with the Zsh shell later by running 'su - testuser -s /bin/zsh' in the terminal."
fi
