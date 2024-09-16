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
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash && \

echo 'Installing all the packages' && \
sudo apt install -y git tree vim ant maven gradle wireless-tools net-tools gnome-shell-extensions preload usb-creator-gtk \
	openjdk-8-jdk openjdk-8-doc openjdk-8-source openjdk-17-jdk openjdk-17-doc openjdk-17-source openjdk-21-jdk openjdk-21-doc openjdk-21-source \
	font-manager python3.9 python3-pip python3-dev gnome-tweaks build-essential libusb-1.0-0-dev \
	libudev-dev tcpdump traceroute gnome-disk-utility ipcalc rhythmbox zeal synaptic pulseaudio \
	obs-studio mesa-vulkan-drivers nvidia-settings vulkan-tools speedtest piper nvidia-driver-535 \
	ntpdate htop nvtop vlc mysql-server gparted libreoffice bleachbit zsh libssl-dev \
	lm-sensors psensor bat boot-repair qdirstat musl xclip ffmpeg pciutils unrar gconf2 parallel \
	whois docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose brave-browser \
	linux-tools-common linux-tools-generic linux-tools-"$(uname -r)" valgrind cmake krita \
	texlive-full biber texlive-lang-spanish texlive-extra-utils sshpass libomp-dev libopenmpi-dev \
 	libasound2-dev mesa-common-dev libx11-dev libxrandr-dev libxi-dev xorg-dev libgl1-mesa-dev inkscape \
  	libglu1-mesa-dev libopenal-dev libdw-dev libevent-dev libhwloc-dev libpmix-dev cmatrix libncurses5 && \

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
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
echo 'Syntax highlighting and autosuggestion plugins installed' && \

# Be able to execute Wireshark from Ubuntu UI without running the command 'sudo wireshark' in the terminal
sudo usermod -aG wireshark samuel && \

# Fix adjustment time between Windows and Ubuntu.
timedatectl set-local-rtc 1 --adjust-system-clock && \

# Install JetBrains Toolbox for managing installed versions of IDEs.
echo 'Installing Jetbrains Toolbox' && \
wget -O ~/jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.4.2.32922.tar.gz && \
tar xzvf ~/jetbrains-toolbox.tar.gz -C ~/ && \
~/jetbrains-toolbox-2.4.2.32922/jetbrains-toolbox && \
rm ~/jetbrains-toolbox.tar.gz && \
rm -r ~/jetbrains-toolbox-2.4.2.32922 && \
echo 'JetBrains Toolbox installed' && \

# Install JetBrains Font in the system
wget -O ~/JetBrainsMono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip && \
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
#wget -O ~/gdrive_linux_amd64.tar.gz https://github.com/prasmussen/gdrive/releases/download/2.1.1/gdrive_2.1.1_linux_amd64.tar.gz && \
#tar xzvf ~/gdrive_linux_amd64.tar.gz -C ~/ && \
#sudo mv ~/gdrive /usr/local/bin && \
#rm ~/gdrive_linux_amd64.tar.gz && \
#echo 'gdrive installed' && \

# Install all snaps
# sudo snap install notion-snap && \
# sudo snap install blender --channel=2.93lts/stable --classic && \
# sudo snap install qbittorrent-arnatious && \
# sudo snap install krita && \
sudo snap install postman && \
sudo snap install code --classic && \
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

# Configure terminal colors
echo 'Configuring terminal colors' && \
mkdir -p ~/.config/terminal && \
echo "[/]
default='ae6ee2e0-d527-4f65-b894-150d29826d4a'
list=['ae6ee2e0-d527-4f65-b894-150d29826d4a']

[:ae6ee2e0-d527-4f65-b894-150d29826d4a]
background-color='rgb(44,44,44)'
cursor-shape='ibeam'
default-size-columns=100
font='JetBrains Mono Medium 12'
foreground-color='rgb(230,230,230)'
palette=['rgb(0,0,0)', 'rgb(255,0,0)', 'rgb(0,255,0)', 'rgb(255,255,0)', 'rgb(0,87,255)', 'rgb(255,0,255)', 'rgb(0,255,255)', 'rgb(255,255,255)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']
use-system-font=false
use-theme-colors=false
use-theme-transparency=true
visible-name='Custom'
" > ~/.config/terminal/terminalColors.dconf && \
dconf load /org/gnome/terminal/legacy/profiles:/ < ~/.config/terminal/terminalColors.dconf && \
echo 'Terminal colors configured' && \

# Install spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg && \
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list && \
sudo apt update && sudo apt install spotify-client && \

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && \

# Minimize a window by clicking the icon in the dock
#gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' && \

# After this, install the suggested packages in other terminal
echo 'Completed installing all the Ubuntu packages' && \
echo 'You must install the following packages manually:' && \
echo '  · nvm (install nodejs and npm lts) -> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash' && \
echo '  · spotify-adblock (repo: https://github.com/abba23/spotify-adblock)' && \
echo '' && \
echo 'You must configure the following programs manually:' && \
echo '  · Terminal with zsh' && \
echo '  · Git ssh keys' && \
echo '  · Discord .deb package' && \
echo '  · Perf path in CLion for profiling' && \
echo '  · Brave browser user and sync'
