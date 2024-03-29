#!/bin/bash

echo 'Updating system' && \
sudo apt update -y && \

# Install required packages for Docker
echo 'Installing Docker' && \
sudo apt install -y curl ca-certificates gnupg lsb-release apt-transport-https && \
sudo mkdir -p /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \

echo 'Added keyring for docker' && \

sudo apt update -y && \

# Install Speedtest
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && \

# ZSH ???
echo 'Installing all the packages' && \
sudo apt install -y git tree wireless-tools net-tools openjdk-8-jdk openjdk-8-doc openjdk-8-source \
	openjdk-17-jdk openjdk-17-doc openjdk-17-source python3-pip python3-dev build-essential htop \
	tcpdump traceroute ipcalc apache2 speedtest ntpdate mysql-server xclip zip unzip unrar parallel \
	whois docker-ce docker-ce-cli containerd.io docker-compose-plugin && \

echo 'All packages installed' && \

sudo usermod -aG docker $USER && \

wget -O ~/maven.zip https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip && \
unzip ~/maven.zip -d ~/ && \
sudo mv ~/apache-maven-3.8.6 /opt && \
rm ~/maven.zip && \
echo 'Maven installed' && \

sudo pip3 install pyOpenSSL --upgrade && \

pip install localstack && \
echo 'Localstack installed' && \

mkdir -p ~/.local/bin && \
wget https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb && \
sudo dpkg -i bat_0.22.1_amd64.deb && \
rm bat_0.22.1_amd64.deb && \
echo 'alias cat="bat"' >> ~/.bashrc && \
echo 'bat installed' && \

# Install JetBrains Font in the system
wget -O ~/JetBrainsMono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip && \
unzip ~/JetBrainsMono.zip && \
rm ~/OFL.txt ~/AUTHORS.txt && \
sudo mkdir -p /usr/share/fonts/truetype/JetBrainsMono && \
sudo mv ~/fonts/ttf/* /usr/share/fonts/truetype/JetBrainsMono && \
fc-cache -f -v && \
rm ~/JetBrainsMono.zip && \
rm -rf ~/fonts && \
echo 'JetBrainsMono font installed' && \

# Install exa (colorful ls)
wget -O ~/exa-linux-x86_64.zip https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip && \
unzip ~/exa-linux-x86_64.zip -d ~/exaDir && \
sudo mv ~/exaDir/bin/exa /usr/local/bin && \
sudo mv ~/exaDir/man/exa* /usr/share/man/man1 && \
sudo mv ~/exaDir/completions/exa.zsh /usr/local/share/zsh/site-functions && \
rm ~/exa-linux-x86_64.zip && \
rm -r ~/exaDir && \
echo 'alias ls="exa"' >> ~/.bashrc && \
echo 'Exa installed' && \

# Install gdrive (Google Drive CLI)
wget -O ~/gdrive_linux_amd64.tar.gz https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_amd64.tar.gz && \
tar xzvf ~/gdrive_linux_amd64.tar.gz -C ~/ && \
sudo mv ~/gdrive /usr/local/bin && \
rm ~/gdrive_linux_amd64.tar.gz && \
echo 'gdrive installed' && \

# Install aws-cli
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o ~/awscliv2.zip && \
unzip ~/awscliv2.zip && \
sudo ~/aws/install && \
rm ~/awscliv2.zip && \
echo 'awscli installed' && \

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \

# After this, install the suggested packages in other terminal
echo 'Completed installing all the Ubuntu packages' && \
echo 'You must configure the following programs manually:' && \
echo '  · Install nvm with the next command: nvm install --lts (after reloading the terminal)' && \
echo '  · Git ssh keys' && \

# Execution command
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/scastd00/dotfiles/main/scripts/initUbuntu20_04_Server.sh)"
