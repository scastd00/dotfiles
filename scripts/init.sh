#!/bin/bash

sudo add-apt-repository ppa:touchegg/stable && \
sudo add-apt-repository ppa:yannubuntu/boot-repair && \
echo 'apt-repositories added' && \

echo 'Updating system' && \
sudo apt update -y && \

# Install required packages for Docker
sudo apt install -y curl ca-certificates gnupg lsb-release apt-transport-https && \
sudo mkdir -p /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list && \

echo 'Added keyrings for docker and brave-browser' && \

sudo apt update -y && \

# Install Speedtest
# curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash && \

echo 'Installing all the packages' && \
sudo apt install -y git tree ant maven gradle wireless-tools net-tools openjdk-8-jdk openjdk-8-doc openjdk-8-source \
	openjdk-17-jdk openjdk-17-doc openjdk-17-source gnome-shell-extensions preload usb-creator-gtk \
	font-manager python3.10 python3-pip python3-dev gnome-tweaks build-essential libusb-1.0-0-dev \
	libudev-dev tcpdump traceroute gnome-disk-utility ipcalc rhythmbox zeal wireshark synaptic pulseaudio \
	obs-studio mesa-vulkan-drivers nvidia-settings vulkan-tools apache2 \
	ntpdate htop vlc mysql-server gparted touchegg libreoffice bleachbit zsh \
	lm-sensors psensor bat boot-repair qdirstat musl xclip ffmpeg pciutils unrar gconf2 parallel \
	whois docker-ce docker-ce-cli containerd.io docker-compose-plugin brave-browser && \

echo 'All packages installed' && \

pip install localstack && \
echo 'Localstack installed' && \

mkdir -p ~/.local/bin && \
ln -s /usr/bin/batcat ~/.local/bin/bat && \
echo 'bat linked' && \

# Fix error 'Could not find child process "net"' in Nautilus file manager
sudo apt install samba-common-bin -y && \
sudo mkdir /var/lib/samba/usershares && \

# Install Oh My ZSH
echo 'Installing Oh My ZSH' && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
echo 'ZSH installed' && \

# Install plugins for Oh My ZSH
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting && \
echo 'Syntax highlighting and autosuggestion plugins installed' && \

# Be able to execute Wireshark from Ubuntu UI without running the command 'sudo wireshark' in the terminal
sudo usermod -aG wireshark samuel && \

# Fix adjustment time between Windows and Ubuntu.
timedatectl set-local-rtc 1 --adjust-system-clock && \

# Install JetBrains Toolbox for managing installed versions of IDEs.
echo 'Installing Jetbrains Toolbox' && \
wget -O ~/jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.26.0.13072.tar.gz && \
tar xzvf ~/jetbrains-toolbox.tar.gz -C ~/ && \
~/jetbrains-toolbox/jetbrains-toolbox && \
rm ~/jetbrains-toolbox.tar.gz && \
rm -r ~/jetbrains-toolbox && \
echo 'JetBrains Toolbox installed' && \

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
echo 'Exa installed' && \

# Install gdrive (Google Drive CLI)
wget -O ~/gdrive_linux_amd64.tar.gz https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_amd64.tar.gz && \
tar xzvf ~/gdrive_linux_amd64.tar.gz -C ~/ && \
sudo mv ~/gdrive /usr/local/bin && \
rm ~/gdrive_linux_amd64.tar.gz && \
echo 'gdrive installed' && \

# Install all snaps
# sudo snap install notion-snap && \
# sudo snap install blender --channel=2.93lts/stable --classic && \
# sudo snap install qbittorrent-arnatious && \
sudo snap install postman && \
sudo snap install code --classic && \
sudo snap install gimp && \
sudo snap install whatsie && \
echo 'Snaps installed' && \

# Install aws-cli
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o ~/awscliv2.zip && \
unzip ~/awscliv2.zip && \
sudo ~/aws/install && \
rm ~/awscliv2.zip && \
echo 'awscli installed' && \

# Install Steam (Check if terminates the execution of the script at some point)
echo 'Installing Steam' && \
wget -O ~/steam.deb http://media.steampowered.com/client/installer/steam.deb && \
sudo dpkg --install ~/steam.deb && \
rm ~/steam.deb && \
echo 'Steam installed' && \

# Minimize a window by clicking the icon in the dock
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' && \

# After this, install the suggested packages in other terminal
echo 'Completed installing all the Ubuntu packages' && \
echo 'You must install the following packages manually:' && \
echo '  · nvidia-driver-###' && \
echo '  · nvm (install nodejs and npm lts) -> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash' && \
echo "  · rust -> curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" && \
echo '  · spotify-adblock (repo: https://github.com/abba23/spotify-adblock)' && \
echo '  · Discord .deb package' && \
echo '' && \
echo 'You must configure the following programs manually:' && \
echo '  · Terminal with zsh' && \
echo '  · Git ssh keys' && \
echo '  · Brave browser user and sync'
