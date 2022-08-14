#!/bin/bash

sudo add-apt-repository ppa:touchegg/stable && \
sudo add-apt-repository ppa:yannubuntu/boot-repair && \

echo 'Updating system' && \
sudo apt update -y && \

# Install required packages for Docker
sudo apt install -y curl ca-certificates gnupg lsb-release && \
sudo mkdir -p /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \

# Install Speedtest
curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash && \

echo 'Installing all the packages' && \
sudo apt install -y git tree ant maven gradle wireless-tools net-tools openjdk-8-jdk openjdk-8-doc openjdk-8-source \
	openjdk-11-jdk openjdk-11-doc openjdk-11-source openjdk-17-jdk openjdk-17-doc openjdk-17-source \
	font-manager ruby-dev python3.8 python3-pip python3-dev gnome-tweaks build-essential libusb-1.0-0-dev \
	libudev-dev tcpdump traceroute gnome-disk-utility ipcalc rhythmbox zeal wireshark qt5-default synaptic pulseaudio \
	obs-studio mesa-vulkan-drivers nvidia-settings speedtest vulkan-tools apache2 \
	vulkan-utils ntpdate htop vlc mysql-server gparted touchegg libreoffice \
	lm-sensors psensor bat boot-repair qdirstat musl xclip ffmpeg pciutils unrar gconf2 parallel \
	whois docker-ce docker-ce-cli containerd.io docker-compose-plugin && \

# To install npm and nodejs we will use nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \

mkdir -p ~/.local/bin && \
ln -s /usr/bin/batcat ~/.local/bin/bat && \

# Nvidia's drivers must be installed manually
# sudo apt install nvidia-driver-510 or other number

# Fix error 'Could not find child process "net"' in Nautilus file manager
sudo apt install samba-common-bin -y && \
sudo mkdir /var/lib/samba/usershares && \

# Install Oh My ZSH
echo 'Installing Oh My ZSH' && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \

# Be able to execute Wireshark from Ubuntu UI without running the command 'sudo wireshark' in the terminal
sudo usermod -aG wireshark samuel && \

# Fix adjustment time between Windows and Ubuntu.
timedatectl set-local-rtc 1 --adjust-system-clock && \

# Install JetBrains Toolbox for managing installed versions of IDEs.
echo 'Installing Jetbrains Toolbox' && \
wget -O ~/jetbrains-toolbox-1.23.11731.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.23.11731.tar.gz && \
tar xzvf ~/jetbrains-toolbox-1.23.11731.tar.gz -C ~/ && \
~/jetbrains-toolbox-1.23.11731/jetbrains-toolbox && \
rm ~/jetbrains-toolbox-1.23.11731.tar.gz && \
rm -r ~/jetbrains-toolbox-1.23.11731 && \

# Install plugins for Oh My ZSH
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \

# Install exa (colorful ls)
wget -O ~/exa-linux-x86_64-v0.10.0.zip https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip && \
unzip ~/exa-linux-x86_64-v0.10.0.zip -d ~/exaDir && \
sudo mv ~/exaDir/bin/exa /usr/local/bin && \
sudo mv ~/exaDir/man/exa* /usr/share/man/man1 && \
sudo mv ~/exaDir/completions/exa.zsh /usr/local/share/zsh/site-functions && \
rm ~/exa-linux-x86_64-v0.10.0.zip && \
rm -r ~/exaDir && \

# Install gdrive (Google Drive CLI)
wget -O ~/gdrive_2.1.1_linux_amd64.tar.gz https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_amd64.tar.gz && \
tar xzvf ~/gdrive_2.1.1_linux_amd64.tar.gz -C ~/ && \
sudo mv ~/gdrive /usr/local/bin && \
rm ~/gdrive_2.1.1_linux_amd64.tar.gz && \

# Install all snaps
sudo snap install notion-snap && \
sudo snap install blender --channel=2.93lts/stable --classic && \
sudo snap install postman && \
sudo snap install discord && \
sudo snap install code --classic && \
sudo snap install gimp && \
sudo snap install qbittorrent-arnatious && \
sudo snap install whatsie && \

# Install Steam (Check if terminates the execution of the script at some point)
echo 'Installing Steam' && \
wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb && \
sudo dpkg --install ~/steam.deb && \
rm ~/steam.deb && \

# Install aws-cli
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o ~/awscliv2.zip && \
unzip ~/awscliv2.zip && \
sudo ~/aws/install && \
rm ~/awscliv2.zip && \

# Install JetBrains font in the system
wget -O ~/JetBrainsMono-2.242.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip && \
unzip ~/JetBrainsMono-2.242.zip && \
rm ~/OFL.txt ~/AUTHORS.txt && \
sudo mkdir -p /usr/share/fonts/truetype/JetBrainsMono && \
sudo mv ~/fonts/ttf/* /usr/share/fonts/truetype/JetBrainsMono && \
fc-cache -f -v && \
rm ~/JetBrainsMono-2.242.zip && \
rm -rf ~/fonts && \

# After this, install the suggested packages in other terminal

echo 'Completed installing all the Ubuntu packages'
echo 'You must install nvidia drivers'
