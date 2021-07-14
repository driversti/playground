#!/bin/bash
# Init script that installs all needed stuff for a new server
set -e

apt update
#apt install -yy openssh-server nano git sudo
apt install -yy sudo
printf "Choose new username: "
read -r USERNAME
USERNAME_HOME="/home/$USERNAME"
echo "Creating user [$USERNAME]"
useradd -s /bin/bash -m $USERNAME
passwd $USERNAME
#MY_SSH_DIR="$USERNAME_HOME/.ssh"
#mkdir "$MY_SSH_DIR"
#chmod 700 "$MY_SSH_DIR"
#SSH_PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDzPgJRg6ybAEKZ2Jde8kNS57A+CA80dpOP9MiDT4sI6KoArifsZy5ausHZF4yjHw1/9jwNZHvB2ufdeFHyLIijRGHD3ce5lPftijA12kY5SXY1dOkPIbXXuoB4CdAkvIVod6fNvn/amzvVv3R1fUN3ChVTvNHD5/AhlcQPtpqpSNbc8WRfgkHqMvsvXy2aMJo1oOF9JpKdP5Be41DvYaQQfQoBNS4lnQwEoxJFqTk9YQLqwlhIjxw/CcMxkLlGnkyiqeGGs4CZpqjkh/Fdkq0ECJ7PiVN7CB809bdeKckae6eGwkilOsiqXDSDXyLCowJ5dIGCO8Dpm0kzJevoMo21 driversti@gmail.com"
#touch $MY_SSH_DIR/authorized_keys
#ls -la $MY_SSH_DIR
#echo "$SSH_PUB_KEY" >> $MY_SSH_DIR/authorized_keys
#ls -la $MY_SSH_DIR
#cat $MY_SSH_DIR/authorized_keys
#chmod 400 $MY_SSH_DIR/authorized_keys
chown $USERNAME:$USERNAME $USERNAME_HOME -R
ls -la $USERNAME_HOME
usermod -aG sudo $USERNAME
#sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
#sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
#service ssh restart
echo "Switching to user: $USERNAME"
su - "$USERNAME"
